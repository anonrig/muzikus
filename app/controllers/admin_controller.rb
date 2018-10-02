class AdminController < ApplicationController
	before_action :set_rights
	def index
	end
# Muzikus Faculty
	def createteacher
		@newTeacher = Teacher.new(teacher_params)
		if @newTeacher.name.length == 0
			redirect_to teachers_path
		else
			Teacher.create(name: @newTeacher.name,
							bio: @newTeacher.bio)
			redirect_to teachers_path
		end
	end

	def updateteacher
		@teacher = Teacher.find(teacher_params[:id])	
		@teacher.update(teacher_params)
		redirect_to teachers_path
	end

	def deleteteacher
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

	def lessons
		@lessons = FacultyLesson.all
		@newLesson = FacultyLesson.new
		@teachers = Teacher.all
	end

	def createlesson
		@newLesson = FacultyLesson.new(lesson_params)
		FacultyLesson.create(name: @newLesson.name,
						teacher_id: @newLesson.teacher_id)
		redirect_to admin_lessons_path
	end

	def deletelesson
		@lesson = FacultyLesson.find(params[:id])
		LessonSchedule.where(faculty_lesson_id: @lesson.id).each do |sch|
			sch.destroy!
		end
		@lesson.destroy!
		redirect_to admin_lessons_path
	end

	def showschedule
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
	
	def createschedule
		puts schedule_params[:start_at]
		@newSchedule = LessonSchedule.new(schedule_params)
		LessonSchedule.create(room_id: @newSchedule.room_id,
								faculty_lesson_id: @newSchedule.faculty_lesson_id,
								weekday: @newSchedule.weekday,
								start_at: @newSchedule.start_at,
								end_at: @newSchedule.end_at)
		redirect_to admin_schedule_path(schedule_params[:room_id])
	end

	def deleteschedule
		@schedule = LessonSchedule.find(params[:id])
		roomid = @schedule.room_id
		@schedule.destroy!
		redirect_to admin_schedule_path(roomid)
	end

	def teacher_params
    	params.require(:teacher).permit(:id, :name, :bio)
    end

    def lesson_params
    	params.require(:faculty_lesson).permit(:id, :name, :teacher_id)
    end

    def schedule_params
    	params.require(:lesson_schedule).permit(:id, :room_id, :weekday, :faculty_lesson_id, :start_at, :end_at)
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
