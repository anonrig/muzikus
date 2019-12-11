class Admin::EventsController < BaseAdminController
    def new
    end

    def create
        @event = Event.new(event_params)

        if @event.save
            flash[:success] = "Successfully created event."
        end
        redirect_to new_admin_event_path
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :details, :location, :starts_at, :photo)
    end
end