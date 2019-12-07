class Api::ReservationsController < ApiController
    def index
        response = ApiModels::BaseApiResponse.new

        reservations = Reservation.all#.where("start_at > ?", Time.now.beginning_of_day - 3.hours).order('start_at ASC')
        response.data = reservations.collect{|x| 
            {
                id: x.id,
                owner: User.find(x.user_id).parse_response,
                room: Room.find(x.room_id).parse_response,
                startDate: x.start_at,
                endDate: x.end_at,
                details: x.detail
            }
        }.to_a
        render json: response
    end

    def create
        response = ApiModels::BaseApiResponse.new
        new_reservation = Reservation.new(reservation_params)

        #User should be a member
        if not current_user.is_member
            render json: {}, :forbidden
            return
        end

        #Form validation
        if(new_reservation.room_id.nil? || new_reservation.start_at.nil? || new_reservation.end_at.nil?)
            response.setMessage("Please fill in all reuqired fields...")
            render json: response
			return
		elsif(new_reservation.start_at > new_reservation.end_at)
            response.setMessage("End date must be greater than start date...")
            render json: response
			return
        end

        #Check hangar and drum availability
        if new_reservation.room_id == ENV['HANGAR_ID'].to_i && !current_user.is_workshop
            response.setMessage("You cannot reserve this room because you didn't take hangar workshop.")
            render json: response
            return
        elsif new_reservation.room_id == ENV['DRUM_ID'].to_i && !current_user.is_drum
            response.setMessage("You cannot reserve this room because you are not taking drum lesson.")
            render json: response
            return
        end

        new_reservation.user_id = current_user.id
        isValid = true

        #take 6 hour interval to check if its occupied before
        reservationsOnThatDay = Reservation.where(room_id: new_reservation.room_id).where('start_at BETWEEN ? AND ?', new_reservation.start_at - 2.hours, new_reservation.start_at + 2.hours)
        reservationsOnThatDay.each do |item|
            if(item.start_at < new_reservation.start_at && item.end_at > new_reservation.start_at)
                isValid = false
            elsif (item.start_at >= new_reservation.start_at && item.start_at < new_reservation.end_at)
                isValid = false
            end						
        end
        
        if not isValid
            response.setMessage("You're trying reserve an occupied spot...")
            render json: response
            return
        end

        #take room schedule on that day
        weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        roomSchedule = LessonSchedule.where(room_id: new_reservation.room_id, weekday: weekdays[new_reservation.start_at.wday - 1])

        #check faculty lessons
        roomSchedule.each do |item|
            startTime = set_schedule_today(new_reservation.start_at, item.start_at)
            endTime = set_schedule_today(new_reservation.start_at, item.end_at)

            if(startTime < new_reservation.start_at && endTime > new_reservation.start_at)
                isValid = false
            elsif (startTime >= new_reservation.start_at && startTime < new_reservation.end_at)
                isValid = false						
            end
        end

        if not isValid
            response.setMessage("There is a faculty lesson or project in this room, don't forget to check the room schedule.")
            render json: response
            return
        end
        
        #max 2 hours per 24 hour interval
        allRes = Reservation.where('start_at BETWEEN ? AND ?', new_reservation.start_at - 12.hours + 1, new_reservation.start_at + 12.hours - 1)
            .where(user_id: current_user.id, room_id: new_reservation.room_id)
        
            total = 0
        allRes.each do |item|
            total += (item.end_at - item.start_at)
        end
        total += (new_reservation.end_at - new_reservation.start_at)

        if total > 7200
            response.setMessage("You can't reserve more than 2 hours in 24 hour interval.")
            render json: response
            return
        end

        new_reservation.save!
        response.message = "Your reservation has been successfully added."
        render json: response
    end

    def destroy
        reservation = Reservation.where(id: params[:id]).first
        if reservation.nil?
            render json: {}, status: :not_found
            return
        end

        room = reservation.room
        manager_ids = room.parse_response[:managers].collect{|x| x[:id]}

        if ((reservation.user_id != current_user.id) and (not manager_ids.include?(current_user.id)))
            render json: {}, status: :forbidden
            return
        end

        reservation.destroy

        response = ApiModels::BaseApiResponse.new
        response.message = "Reservation has been deleted successfully..."
        response.data = true
        render json: response 
    end

    private

    def reservation_params
        params.require(:reservation).permit(:room_id, :start_at, :end_at, :detail)
    end
end