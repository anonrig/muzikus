class Room < ActiveRecord::Base
	has_many :reservations
	has_many :managers
	has_many :lesson_schedules
	has_many :users, through: :reservations
	has_many :users, through: :managers
	has_many :faculty_lesson, through: :lesson_schedules

	def parse_response
		{
			id: self.id,
			name: self.name,
			managers: self.managers.collect{|x| x.parse_response}
		}
	end
end
