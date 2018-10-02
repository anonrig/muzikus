class RoomsController < ApplicationController
    before_action :set_rights

    def index
        @rooms = Room.all
		@newRoom = Room.new
    end
    
    def show
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