class EventsController < ApplicationController

    # GET /events
    def index
        @events = Event.all
        render json: @events
    end

    # GET /event/:id
    def show
        if not params[:id] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
            render json: { error: 'Event ID is invalid.' }, status: 400
        else 
            begin
                @event = Event.find(params[:id])
                render json: @event
            rescue ActiveRecord::RecordNotFound
                render json: { error: 'Cannot find the event.' }, status: 400
            end
        end
    end

    # POST /events
    def create
        @event = Event.new(event_params)
        if @event.save
            render json: { message: 'Event succeessfully store in the DB.', event: @event.attributes.slice('id', 'name', 'event_type', 'created_at'), details: JSON.parse(@event[:details])}
        else
            render json: @event.errors.messages, status: 422
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
        puts params
        puts params.as_json
        puts request.body.read
        puts JSON.parse(request.body.read).to_json

        params.require(:event).permit(:name, :event_type).merge({"details": JSON.parse(request.body.read).to_json})
    end
end
