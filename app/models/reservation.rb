class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :room

	def as_json(options={})
		super(
            except: [:created_at, :updated_at],
			methods: [:user, :room_name, :managers]
		)
	end
	
	def user
		user = User.find(self.user_id)
		Hash[name: user.name, email: user.email]
	end

	def room_name
		Room.find(self.room_id).name
	end

	def managers
		managers = Manager.where(room_id: self.room_id)
		managers.map{|manager| Hash[user_id: manager.user_id, name: manager.user[:name], phone: manager.manager_num]}
	end
end
