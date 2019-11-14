class ReservationsController < ApplicationController
	before_action :set_rights
	def index
		@hangar_id = ENV["HANGAR_ID"].to_i
		@drum_id = ENV["DRUM_ID"].to_i
		@memberList = User.where(is_member: true)
		@newReservation = Reservation.new
		@rooms = Room.all
		
		#Room schedules
		@tmpRooms = Room.all.to_a.map(&:serializable_hash)

        @tmpRooms.each do |room|
            schedule = {
                :Monday => LessonSchedule.where("room_id = ? AND weekday = ?", room["id"], "Monday").order("start_at ASC").to_a.map(&:serializable_hash),
                :Tuesday => LessonSchedule.where("room_id = ? AND weekday = ?", room["id"], "Tuesday").order("start_at ASC").to_a.map(&:serializable_hash),
                :Wednesday => LessonSchedule.where("room_id = ? AND weekday = ?", room["id"], "Wednesday").order("start_at ASC").to_a.map(&:serializable_hash),
                :Thursday => LessonSchedule.where("room_id = ? AND weekday = ?", room["id"], "Thursday").order("start_at ASC").to_a.map(&:serializable_hash),
                :Friday => LessonSchedule.where("room_id = ? AND weekday = ?", room["id"], "Friday").order("start_at ASC").to_a.map(&:serializable_hash),
                :Saturday => LessonSchedule.where("room_id = ? AND weekday = ?", room["id"], "Saturday").order("start_at ASC").to_a.map(&:serializable_hash),
                :Sunday => LessonSchedule.where("room_id = ? AND weekday = ?", room["id"], "Sunday").order("start_at ASC").to_a.map(&:serializable_hash)
            }
            room[:schedule] = schedule
        end
        @lessons = FacultyLesson.all.to_a
        
        @tmpRooms = JSON.parse(@tmpRooms.to_json, object_class: OpenStruct)
		
		#Room Managers
		@managers = Manager.all.to_json

		@reservations = Reservation.where("start_at > ?", Time.now.beginning_of_day - 3.hours).order('start_at ASC')
		respond_to do |format|
			format.html
			format.json { render json: @reservations }
		end
	end

	#to compare room schedule with reservation time
	def set_schedule_today(date1, date2)
		arr = date1.to_a
		arr2 = date2.to_a
		Time.new(arr[5], arr[4], arr[3], arr2[2], arr2[1], arr2[0], "+03:00")
	end

	def create
		@newReservation = Reservation.new(reservation_params)
		
		if(@newReservation.room_id.nil? || @newReservation.start_at.nil? || @newReservation.end_at.nil?)
			render json: {type: 'warning', message: 'It seems like you forgot something, master.'}, status: :not_acceptable
		elsif(@newReservation.start_at > @newReservation.end_at)
			render json:  {type: 'warning', message: 'Unknown error... Please refresh the current page and try again.'}, status: :not_acceptable
		else
			if current_user && current_user.is_member
				if @newReservation.room_id == ENV['HANGAR_ID'].to_i && !current_user.is_workshop
					render json: {type: 'error', title: 'Oh snap!', text: 'You cannot reserve this room because you didn\'t take hangar workshop.'}, status: :not_acceptable
				elsif @newReservation.room_id == ENV['DRUM_ID'].to_i && !current_user.is_drum
					render json: {type: 'error', title: 'Oh snap!', text: 'You cannot reserve this room because you are not taking drum lesson.'}, status: :not_acceptable
				end
				@newReservation.user_id = current_user.id
				isValid = true
				#take 6 hour interval to check if its occupied before
				reservationsOnThatDay = Reservation.where(room_id: @newReservation.room_id).where('start_at BETWEEN ? AND ?', @newReservation.start_at - 2.hours, @newReservation.start_at + 2.hours)
				#take room schedule on that day
				weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
				roomSchedule = LessonSchedule.where(room_id: @newReservation.room_id, weekday: weekdays[@newReservation.start_at.wday - 1])

				reservationsOnThatDay.each do |item|
					if(item.start_at < @newReservation.start_at && item.end_at > @newReservation.start_at)
						isValid = false
					elsif (item.start_at >= @newReservation.start_at && item.start_at < @newReservation.end_at)
						isValid = false
					end						
				end
				
				if isValid
					#check faculty lessons
					roomSchedule.each do |item|
						startTime = set_schedule_today(@newReservation.start_at, item.start_at)
						endTime = set_schedule_today(@newReservation.start_at, item.end_at)

						if(startTime < @newReservation.start_at && endTime > @newReservation.start_at)
							isValid = false
							render json: {type: 'error', title: 'Oh snap!', text: 'There is a faculty lesson or project in this room, don\'t forget to check the room schedule.'}, status: :not_acceptable
							break
						elsif (startTime >= @newReservation.start_at && startTime < @newReservation.end_at)
							isValid = false
							render json: {type: 'error', title: 'Oh snap!', text: 'There is a faculty lesson or project in this room, don\'t forget to check the room schedule.'}, status: :not_acceptable
							break							
						end
					end
					#max 2 hours
					if isValid
						allRes = Reservation.where('start_at BETWEEN ? AND ?',
													@newReservation.start_at - 12.hours + 1,
													@newReservation.start_at + 12.hours - 1).where(user_id: current_user.id,
																						room_id: @newReservation.room_id)
						total = 0
						allRes.each do |item|
							total += (item.end_at - item.start_at)
						end
						total += (@newReservation.end_at - @newReservation.start_at)
						if total <= 60*60*2
							@newReservation.save!
							render json: {type: 'success', title: 'Success!', text: 'Your reservation has been successfully added.', data: @newReservation}, status: :ok
						else
							render json: {type: 'error', title: 'Oh snap!', text: 'You can\'t reserve more than 2 hours in 24 hour interval.'}, status: :not_acceptable
						end
					end
				else
					render json: {type: 'error', title: 'Oh snap!', text: 'You\'re trying to reserve to an occupied spot.'}, status: :not_acceptable
				end
			else
				render json: {}, status: :forbidden
			end
		end
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		if (@reservation.user_id == current_user.id) || (not Manager.where(room_id: @reservation.room_id, user_id: current_user.id).first.nil?)
			@reservation.destroy!
			render json: {}, status: :ok
		else
			redirect_to root_path
		end
	end

	def set_rights
		if current_user
			if not current_user.is_member
				redirect_to root_path
			end
		else
			redirect_to root_path
		end
	end

	def reservation_params
      params.require(:reservation).permit(:user_id, :room_id, :start_at, :end_at, :is_canceled, :detail)
    end
end
