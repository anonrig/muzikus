class ManagersController < ApplicationController
    before_action :set_rights

    def index
        @managers = Manager.all
		@ykList = User.where(is_yk: true)
		@rooms = Room.all
		@newManager = Manager.new
    end

    def create
        @newManager = Manager.new(manager_params)
		Manager.create(user_id: @newManager.user_id,
						room_id: @newManager.room_id)
		redirect_to admin_managers_path
    end

    def destroy
        @manager = Manager.find(params[:id])
		@manager.destroy!
		redirect_to admin_managers_path
    end

    private
        def set_rights
            if current_user && current_user.is_member
                if not current_user.is_myk
                    redirect_to root_path
                end
            else
                redirect_to root_path
            end
        end

        def manager_params
            params.require(:manager).permit(:user_id, :room_id)
        end
end