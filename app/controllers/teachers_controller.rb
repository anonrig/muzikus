class TeachersController < ApplicationController
  before_action :set_rights, only: [:create, :update, :destroy]
  def index
  	@teachers = Teacher.all
  	@newTeacher = Teacher.new
  end

  def create
    @newTeacher = Teacher.new(teacher_params)
		if @newTeacher.name.length == 0
			redirect_to teachers_path
		else
			Teacher.create(name: @newTeacher.name,
							bio: @newTeacher.bio)
			redirect_to teachers_path
		end
  end

  def update
    @teacher = Teacher.find(teacher_params[:id])	
		@teacher.update(teacher_params)
		redirect_to teachers_path
  end

  def destroy
    @teacher = Teacher.find(params[:id])
		FacultyLesson.where(teacher_id: @teacher.id).each do |lesson|
			LessonSchedule.where(faculty_lesson_id: lesson.id).each do |sch|
				sch.destroy!
			end
			lesson.destroy!
		end	
		@teacher.destroy!
		redirect_to teachers_path
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

    def teacher_params
      params.require(:teacher).permit(:id, :name, :bio)
    end
end
