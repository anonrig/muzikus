class Admin::FacultyLessonsController < BaseAdminController

    def index
        @lessons = FacultyLesson.all.collect{|x| {id: x.id, name: x.name, teacher_name: x.teacher.name}}
        @lessons = JSON.parse(@lessons.to_json, object_class: OpenStruct)

        #New lesson form
        @teacherSelect = Teacher.all.collect{|x| {text: x.name, val: x.id}}
        @teacherSelect = JSON.parse(@teacherSelect.to_json, object_class: OpenStruct)
    end

    def show
    end

    def create
        FacultyLesson.create(lesson_params)
        redirect_to admin_faculty_lessons_path
    end

    def update
    end

    def destroy
        lesson = FacultyLesson.where(id: params[:id]).first
        if lesson.nil?
            render "error_pages/404", layout: false, status: :not_found
            return
        end

        lesson.lesson_schedules.destroy_all
        lesson.destroy
        render json: {}, status: :ok
    end

    private
    def lesson_params
        params.require(:faculty_lesson).permit(:name, :teacher_id)
    end

end