class AdminController < ApplicationController
	before_action :set_rights
	def index
	end
# User list & Alfonso
	def users
		@users = User.all
		@newMember = User.new
	end

	def createuser
		@newMember = User.new(user_params)
		if not User.find_by(email: @newMember.email+"@sabanciuniv.edu").nil?
			User.where(email: @newMember.email+"@sabanciuniv.edu").update(is_member: @newMember.is_member, 
																			is_yk: @newMember.is_yk,
																			is_myk: @newMember.is_myk,
																			is_workshop: @newMember.is_workshop,
																			is_drum: @newMember.is_drum)
			redirect_to admin_users_path
		else
			User.create(email: @newMember.email+"@sabanciuniv.edu",
						is_member: @newMember.is_member, 
						is_yk: @newMember.is_yk,
						is_myk: @newMember.is_myk,
						is_workshop: @newMember.is_workshop,
						is_drum: @newMember.is_drum)
			redirect_to admin_users_path
		end
	end

	def deleteuser
		@user = User.find(params[:id])
		@user.update(is_member: 0,
					is_yk: 0,
					is_myk: 0,
					is_drum: 0,
					is_workshop: 0)
		redirect_to admin_users_path
	end

	def rooms
		@rooms = Room.all
		@newRoom = Room.new
	end

	def createroom
		@newRoom = Room.new(room_params)
		Room.create(name: @newRoom.name)
		redirect_to admin_rooms_path
	end

	def updateroom
		@room = Room.find(room_params[:id])
		@room.update(room_params)
		redirect_to admin_rooms_path
	end

	def deleteroom
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

	def managers
		@managers = Manager.all
		@ykList = User.where(is_yk: true)
		@rooms = Room.all
		@newManager = Manager.new
	end

	def createmanager
		@newManager = Manager.new(manager_params)
		Manager.create(user_id: @newManager.user_id,
						room_id: @newManager.room_id)
		redirect_to admin_managers_path
	end

	def deletemanager
		@manager = Manager.find(params[:id])
		@manager.destroy!
		redirect_to admin_managers_path
	end

	def user_params
    	params.require(:user).permit(:email, :is_member, :is_yk, :is_myk, :is_workshop, :is_drum)
    end

    def room_params
    	params.require(:room).permit(:id, :name)
    end

    def manager_params
    	params.require(:manager).permit(:id, :room_id, :user_id, :manager_num)
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

# Budget Status
	def budgetstatus
		@budgets = Budget.all.order('created_at DESC')
		@newBudget = Budget.new
		@total = Budget.where(budget_type: "Income").sum(:amount) - Budget.where(budget_type: "Expense").sum(:amount)
	end

	def createbudget
		@budget = Budget.new(budget_params)
		@budget.save!
		redirect_to admin_budget_path
	end

	def budget_params
		params.require(:budget).permit(:amount, :reason, :budget_type, :user_id)
	end
end
