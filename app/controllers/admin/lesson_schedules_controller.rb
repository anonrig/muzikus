class Admin::LessonSchedulesController < BaseAdminController

    def index
        @rooms = Room.all.to_a.map(&:serializable_hash)

        @rooms.each do |room|
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
        
        @rooms = JSON.parse(@rooms.to_json, object_class: OpenStruct)

        #New schedule models
        @roomSelect = Room.all.collect{|x| OpenStruct.new(val: x.id, text: x.name)}
        @lessonSelect = FacultyLesson.all.collect{|x| OpenStruct.new(val: x.id, text: x.name)}
        @daySelect = Date::DAYNAMES.rotate(1)
    end

    def create
        @newSchedule = LessonSchedule.new(schedule_params)

        if  @newSchedule.room_id.nil? or @newSchedule.faculty_lesson_id.nil? or @newSchedule.weekday.nil? or @newSchedule.start_at.nil? or @newSchedule.end_at.nil?
            flash[:danger] = "All fields are required..."
            redirect_to admin_lesson_schedules_path
            return
        end

        if @newSchedule.start_at >= @newSchedule.end_at
            flash[:danger] = "Start time must be greater than end time..."
            redirect_to admin_lesson_schedules_path
            return
        end

        @newSchedule.save
		redirect_to admin_lesson_schedules_path
    end

    def destroy
        @schedule = LessonSchedule.find(params[:id])
		roomid = @schedule.room_id
		@schedule.destroy!
		redirect_to admin_lesson_schedules_path
    end

    private
    def schedule_params
        params.require(:lesson_schedule).permit(:id, :room_id, :weekday, :faculty_lesson_id, :start_at, :end_at)
    end
end