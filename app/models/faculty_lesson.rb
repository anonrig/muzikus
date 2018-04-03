class FacultyLesson < ActiveRecord::Base
	belongs_to :teacher
	has_many :lesson_schedules
	has_many :room, through: :lesson_schedules
end
