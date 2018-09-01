class EventsController < ApplicationController
    before_action :set_rights, only: [:new, :create, :edit, :update, :destroy]
    
    def index
    end

    def get_all
        @events = Event.all

        render json: @events
    end

    def show
        @event = Event.find(params[:id])

        render json: @event
    end

    def new
        @event = Event.new
    end

    def create
        @event = Event.new(event_params)

        if @event.save
            flash[:notice] = "Successfully created event."
            redirect_to events_path
        else
            render :action => 'new'
        end
    end

    def edit
        @event = Event.find(params[:id])
    end

    def update
        @event = Event.find(params[:id])

        @event.update(event_params)

        redirect_to events_path
    end

    def destroy
        @event = Event.find(params[:id])

        if @event.destroy
            redirect_to events_path
        else
            redirect_to edit_event_path(@event)
        end
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :details, :location, :starts_at, :photo)
    end

    def set_rights
        if current_user && current_user.is_member
			if not current_user.is_yk
				redirect_to root_path
			end
		else
			redirect_to root_path
		end
    end

end
