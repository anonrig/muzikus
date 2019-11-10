class Manager < ActiveRecord::Base
	belongs_to :user
	belongs_to :room

	def as_json(options={})
		super(
            except: [:created_at, :updated_at],
			methods: [:user]
		)
	end

	def user
		user = User.find(self.user_id)
		Hash[name: user.name, email: user.email]
	end
end
