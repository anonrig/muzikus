class LessonSchedulesController < ApplicationController
    before_action :set_rights

    def create
        @newSchedule = LessonSchedule.new(schedule_params)
		LessonSchedule.create(room_id: @newSchedule.room_id,
								faculty_lesson_id: @newSchedule.faculty_lesson_id,
								weekday: @newSchedule.weekday,
								start_at: @newSchedule.start_at,
								end_at: @newSchedule.end_at)
		redirect_to admin_room_path(schedule_params[:room_id])
    end

    def destroy
        @schedule = LessonSchedule.find(params[:id])
		roomid = @schedule.room_id
		@schedule.destroy!
		redirect_to admin_room_path(roomid)
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

        def schedule_params
            params.require(:lesson_schedule).permit(:id, :room_id, :weekday, :faculty_lesson_id, :start_at, :end_at)
        end
end