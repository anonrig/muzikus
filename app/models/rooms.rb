class Rooms < ActiveRecord::Base
	# Name
	#
	#
	#
	#

	has_many :reservations
	has_many :roomschedule
end
