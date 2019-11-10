class Admin::ManagersController < BaseAdminController
    def index
        managers = Manager.all
		@rooms = Room.all.to_a.map(&:serializable_hash)
        @rooms.each do |room|
            room[:managers] = managers.where(room_id: room["id"]).collect{ |x| {id: x.id, name: x.user[:name], manager_num: x.manager_num} }
        end
        @rooms = JSON.parse(@rooms.to_json, object_class: OpenStruct)
        #New manager models
        @newManager = Manager.new
		@ykSelect = User.where(is_yk: true).collect{|x| OpenStruct.new(val: x.id, text: "#{x.name.nil? ? "Unknown Name" : x.name} - #{x.email}")}
        @roomSelect = Room.all.collect{|x| OpenStruct.new(val: x.id, text: x.name)}
    end

    def create
        @newManager = Manager.new(manager_params)
        if @newManager.user_id.nil? ||  @newManager.room_id.nil? || @newManager.manager_num.nil?
            flash[:danger] = "All fields are required..."
            redirect_to admin_managers_path
            return
        end
		@newManager.save
		redirect_to admin_managers_path
    end

    def destroy
        @manager = Manager.where(id: params[:id]).first
        if @manager.nil?
            render "error_pages/404", layout: false, status: :not_found
            return
        end

		@manager.destroy
		render json: {}, status: :ok
    end

    private
    def manager_params
        params.require(:manager).permit(:user_id, :room_id, :manager_num)
    end

end