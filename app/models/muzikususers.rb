class Muzikususers < ActiveRecord::Base
	# Email 
	# sid (student_id:integer)
	# isyk: boolean

	belongs_to :user, :class_name => 'Users', :foreign_key => "sabancimail"
end
