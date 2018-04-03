class Room < ActiveRecord::Base
	has_many :reservations
	has_many :managers
	has_many :lesson_schedules
	has_many :user, through: :reservations
	has_many :user, through: :managers
	has_many :faculty_lesson, through: :lesson_schedules
end
