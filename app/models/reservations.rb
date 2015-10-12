class Reservations < ActiveRecord::Base
	# User_id 
	# Room_id
	# Start_date
	# End_date
	# Day (integer)
	# isCanceled (false automatically)

	belongs_to :user, :class_name => "Users", :foreign_key => "user_id"
	belongs_to :room, :class_name => "Rooms", :foreign_key => "room_id"
end
