class FacultyStudent < ActiveRecord::Base
	belongs_to :user
	belongs_to :faculty_lesson
end
