class RoomsController < ApplicationController
    before_action :set_rights

    def index
        @rooms = Room.all
		@newRoom = Room.new
    end
    
    def show
        @room = Room.find(params[:id])
		@lessons = FacultyLesson.all
		@schedule = {
			:Monday => LessonSchedule.where("room_id = ? AND weekday = ?", @room.id, "Monday").order("start_at ASC"),
			:Tuesday => LessonSchedule.where("room_id = ? AND weekday = ?", @room.id, "Tuesday").order("start_at ASC"),
			:Wednesday => LessonSchedule.where("room_id = ? AND weekday = ?", @room.id, "Wednesday").order("start_at ASC"),
			:Thursday => LessonSchedule.where("room_id = ? AND weekday = ?", @room.id, "Thursday").order("start_at ASC"),
			:Friday => LessonSchedule.where("room_id = ? AND weekday = ?", @room.id, "Friday").order("start_at ASC"),
			:Saturday => LessonSchedule.where("room_id = ? AND weekday = ?", @room.id, "Saturday").order("start_at ASC"),
			:Sunday => LessonSchedule.where("room_id = ? AND weekday = ?", @room.id, "Sunday").order("start_at ASC")
			}
		@newSchedule = LessonSchedule.new

		@count = 0
		@schedule.each { |sch|
			@count+= sch[1].length
		}
    end
    
    def edit
    end

    def create
        @newRoom = Room.new(room_params)
		Room.create(name: @newRoom.name)
		redirect_to admin_rooms_path
    end

    def update
        @room = Room.find(room_params[:id])
		@room.update(room_params)
		redirect_to admin_rooms_path
    end

    def destroy
        @room = Room.find(params[:id])
		LessonSchedule.where(room_id: @room.id).each do |sch|
			sch.destroy!
		end
		Reservation.where(room_id: @room.id).each do |res|
			res.destroy!
		end
		Manager.where(room_id: @room.id).each do |man|
			man.destroy!
		end
		@room.destroy!
		redirect_to admin_rooms_path
    end

    private
        def set_rights
            if current_user && current_user.is_member
                if not current_user.is_myk
                    redirect_to root_path
                end
            else
                redirect_to root_path
            end
        end

        def room_params
            params.require(:room).permit(:name)
        end
end