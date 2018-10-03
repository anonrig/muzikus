class AdminController < ApplicationController
	before_action :set_rights
	def index
	end

	def set_rights
		if current_user && current_user.is_member
			if not current_user.is_myk
				redirect_to root_path
			end
		else
			redirect_to root_path
		end
	end
end
