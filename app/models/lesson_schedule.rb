class LessonSchedule < ActiveRecord::Base
	belongs_to :room
	belongs_to :faculty_lesson
end
