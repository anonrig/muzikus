class Users < ActiveRecord::Base

	belongs_to :muzikususer, :class_name => 'Users', :foreign_key => "email"
	has_many :budgets
	belongs_to :scout, :class_name => 'Scouts', :foreign_key => "id"
	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.email = auth.extra.raw_info.email
	    user.oauth_token = auth.credentials.token
	    user.save!
	  end
	end

end
