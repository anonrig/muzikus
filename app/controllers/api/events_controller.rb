class Api::EventsController < ApplicationController
    def index
        @events = Event.all.order("starts_at DESC")
        render json: @events
    end

    def show
        @event = Event.find(params[:id])
        render json: @event
    end
end