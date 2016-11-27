class Post < ActiveRecord::Base

  	belongs_to :user, :class_name => "Users", :foreign_key => "user_id"
    belongs_to :subject, :foreign_key =>"subject_id"
end
