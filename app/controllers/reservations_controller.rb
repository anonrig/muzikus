class ReservationsController < ApplicationController
	before_action :set_rights
	def index
		@reservations = Reservation.where("start_at > ?", Time.now.beginning_of_day - 3.hours).order('start_at ASC')
		@memberList = User.where(is_member: true)
		@rooms = Room.all
		@lessons = FacultyLesson.all
		@newReservation = Reservation.new
		@hangar_id = ENV["HANGAR_ID"]
		@drum_id = ENV["DRUM_ID"]
	end

	#to compare room schedule with reservation time
	def set_schedule_today(date1, date2)
		arr = date1.to_a
		arr2 = date2.to_a
		Time.new(arr[5], arr[4], arr[3], arr2[2], arr2[1], arr2[0], "+00:00")
	end

	def create
		@newReservation = Reservation.new(reservation_params)
		puts reservation_params[:start_at]
		puts reservation_params[:end_at]
		if(@newReservation.room_id.nil? || @newReservation.start_at.nil? || @newReservation.end_at.nil?)
			redirect_to reservations_path, notice: 'formempty'
		else
			if current_user && current_user.is_member
				if params[:reservation][:user_id].to_i == current_user.id
					isValid = true
					#take 6 hour interval to check if its occupied before
					reservationsOnThatDay = Reservation.where(room_id: @newReservation.room_id).where('start_at BETWEEN ? AND ?', @newReservation.start_at - 3.hours, @newReservation.start_at + 3.hours)
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
					puts @newReservation.start_at
					puts @newReservation.end_at
					if isValid
						#check faculty lessons
						roomSchedule.each do |item|
							startTime = set_schedule_today(@newReservation.start_at, item.start_at)
							endTime = set_schedule_today(@newReservation.start_at, item.end_at)

							if(startTime < @newReservation.start_at && endTime > @newReservation.start_at)
								isValid = false
								redirect_to reservations_path, notice: 'faculty'
								break
							elsif (startTime >= @newReservation.start_at && startTime < @newReservation.end_at)
								isValid = false
								redirect_to reservations_path, notice: 'faculty'
								break							
							end
						end
						#max 3 hours
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
								Reservation.create(user_id: @newReservation.user_id,
													room_id: @newReservation.room_id,
													start_at: @newReservation.start_at,
													end_at: @newReservation.end_at,
													is_canceled: @newReservation.is_canceled)
								redirect_to reservations_path, notice: 'created'
							else
								redirect_to reservations_path, notice: 'hourcount'
							end
						end
					else
						redirect_to reservations_path, notice: 'occupied'
					end
				else
					redirect_to root_path
				end
			else
				redirect_to root_path
			end
		end
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		if @reservation.user_id == current_user.id
			@reservation.destroy!
			redirect_to reservations_path
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
      params.require(:reservation).permit(:user_id, :room_id, :start_at, :end_at, :is_canceled)
    end
end
