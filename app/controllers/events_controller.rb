class EventsController < ApplicationController

    # GET /events
    def index
        @events = Event.all
        render json: @events
    end

    # GET /event/:id
    def show
        @event = Event.find(params[:id])
        render json: @event
    end

    # POST /events
    def create
        @event = Event.new(event_params)
        if @event.save
            render json: @event
        else
            render error: { error: 'Unable to create Event.' }, status: 400
        end
    end

    # PUT /events/:id
    def update
    end

    # DELETE /events/:id
    def destroy
        @event = Event.find(params[:id])
        if @event
            @event.destroy
            render json: { message: 'Event successfully deleted.' }, status: 200
        else
            render json: { error: 'Unable to delete Event.' }, status: 400
        end 
    end

    private

    def event_params
        params.require(:event).permit(:name, :event_type)
    end
end
