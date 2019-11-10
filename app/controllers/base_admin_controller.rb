class BaseAdminController < ApplicationController
	layout "admin"
	before_action :set_rights
	before_action :admin_authorization, only: [:create, :update, :destroy]
	
	def set_rights
		if current_user && current_user.is_member
			if not (current_user.is_yk or current_user.is_myk)
				redirect_to root_path
			end
		else
			redirect_to root_path
		end
	end

	def admin_authorization
		if not current_user.is_myk
			redirect_to controller: "main", action: "index"
		end
	end
end
