class User < ActiveRecord::Base
	has_one :scout_profile
	has_many :reservations
	has_many :managers
	has_many :room, through: :reservations
	has_many :room, through: :managers
	has_many :budget

	def self.sign_in_from_omniauth(auth)
		find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
	end

	def self.create_user_from_omniauth(auth)
		temp = find_by(email: auth['info']['email'])
		if (temp != nil)
			temp.update(provider: auth['provider'],
						uid: auth['uid'],
						name: auth['info']['name'].split(' (Student)')[0]
						)
			return find_by(id: temp.id)
		else
			create(
			provider: auth['provider'],
			uid: auth['uid'],
			name: auth['info']['name'].split(' (Student)')[0],
			email: auth['info']['email'],
			is_member: false,
			is_yk: false,
			is_myk: false,
			is_workshop: false,
			is_drum: false
			)
		end
	end

	def parse_response
		{
			id: self.id,
			fullName: self.name,
			email: self.email,
			profilePic: nil,
			isMember: self.is_member,
			role: self.is_myk ? 1 : self.is_yk ? 2 : 3
		}
	end
end
