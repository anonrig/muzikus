class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :room

	def as_json(options={})
		super(
            except: [:created_at, :updated_at],
			methods: [:user, :room_name]
		)
	end
	
	def user
		user = User.find(self.user_id)
		Hash[name: user.name, email: user.email]
	end

	def room_name
		Room.find(self.room_id).name
	end
end
