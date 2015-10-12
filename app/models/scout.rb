class Scout < ActiveRecord::Base
	belongs_to :user, :class_name => 'Users', :foreign_key => "user_id"
end
