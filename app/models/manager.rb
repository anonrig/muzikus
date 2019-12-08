class Manager < ActiveRecord::Base
	belongs_to :user
	belongs_to :room

	def as_json(options={})
		super(
            except: [:created_at, :updated_at],
			methods: [:manager]
		)
	end

	def manager
		user = User.find(self.user_id)
		Hash[name: user.name, email: user.email]
	end

	def parse_response
		{
			id: self.user.id,
			fullName: self.user.name,
			email: self.user.email,
			profilePic: nil,
			phone_number: self.manager_num,
			isMember: self.user.is_member,
			role: self.user.is_myk ? 1 : self.user.is_yk ? 2 : 3
		}
	end
end
