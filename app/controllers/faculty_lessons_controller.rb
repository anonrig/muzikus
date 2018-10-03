class FacultyLessonsController < ApplicationController
    before_action :set_rights

    def index
        @lessons = FacultyLesson.all
		@newLesson = FacultyLesson.new
		@teachers = Teacher.all
    end

    def show
    end

    def edit
    end

    def create
        @newLesson = FacultyLesson.new(lesson_params)
		FacultyLesson.create(name: @newLesson.name,
						teacher_id: @newLesson.teacher_id)
		redirect_to admin_lessons_path
    end

    def update
    end

    def destroy
        @lesson = FacultyLesson.find(params[:id])
		LessonSchedule.where(faculty_lesson_id: @lesson.id).each do |sch|
			sch.destroy!
		end
		@lesson.destroy!
		redirect_to admin_lessons_path
    end

    private
    
    def lesson_params
        params.require(:faculty_lesson).permit(:id, :teacher_id, :name)
    end

    def set_rights
        if current_user && current_user.is_member
            if not current_user.is_myk
                redirect_to root_path
            end
        else
            redirect_to root_path
        end
    end
end