class Admin::RoomsController < BaseAdminController
    
    def index
        @rooms = Room.all
		@newRoom = Room.new
    end
    
	def show
		#Get current room
        @room = Room.where(id: params[:id]).first
        if @room.nil?
            render "error_pages/404", layout: false, status: :not_found
            return
		end

		#Room schedule
		@room = @room.serializable_hash
		schedule = {
			:Monday => LessonSchedule.where("room_id = ? AND weekday = ?", @room["id"], "Monday").order("start_at ASC").to_a.map(&:serializable_hash),
			:Tuesday => LessonSchedule.where("room_id = ? AND weekday = ?", @room["id"], "Tuesday").order("start_at ASC").to_a.map(&:serializable_hash),
			:Wednesday => LessonSchedule.where("room_id = ? AND weekday = ?", @room["id"], "Wednesday").order("start_at ASC").to_a.map(&:serializable_hash),
			:Thursday => LessonSchedule.where("room_id = ? AND weekday = ?", @room["id"], "Thursday").order("start_at ASC").to_a.map(&:serializable_hash),
			:Friday => LessonSchedule.where("room_id = ? AND weekday = ?", @room["id"], "Friday").order("start_at ASC").to_a.map(&:serializable_hash),
			:Saturday => LessonSchedule.where("room_id = ? AND weekday = ?", @room["id"], "Saturday").order("start_at ASC").to_a.map(&:serializable_hash),
			:Sunday => LessonSchedule.where("room_id = ? AND weekday = ?", @room["id"], "Sunday").order("start_at ASC").to_a.map(&:serializable_hash)
		}
		@room[:schedule] = schedule
		@lessons = FacultyLesson.all.to_a

		@room = JSON.parse(@room.to_json, object_class: OpenStruct)
		
		#Get manager list
		managers = Manager.where(room_id: @room.id).to_a
		@managers = []
		managers.each do |item|
			tmpUser = User.where(id: item.user_id).first
			if tmpUser
				@managers << { 
					id: tmpUser.id,
					name: tmpUser.name,
					phone: item.manager_num	
				}
			end
		end

		@managers = JSON.parse(@managers.to_json, object_class: OpenStruct)

		#Get latest reservations (last 10)
		reservations = Reservation.where(room_id: @room.id).order("start_at DESC").take(5).to_a
		@reservations = []
		reservations.each do |item|
			tmpUser = User.where(id: item.user_id).first
			if tmpUser
				@reservations << {
					id: item.id,
					user: {
						id: tmpUser.id,
						name: tmpUser.name
					},
					start_at: item.start_at,
					end_at: item.end_at
				}
			end
		end

		@reservations = JSON.parse(@reservations.to_json, object_class: OpenStruct)
    end
    
end