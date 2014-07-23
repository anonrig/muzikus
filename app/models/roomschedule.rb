class Roomschedule < ActiveRecord::Base
	# Name
	# Start_date
	# End_date
	# Room_id 
	# Day (integer)

belongs_to :room, :class_name => "Rooms", :foreign_key => "room_id"
end
