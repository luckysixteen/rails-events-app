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
                render json: { event: @event.attributes.slice('id', 'name', 'event_type', 'created_at'), details: JSON.parse(@event[:details])}
            rescue ActiveRecord::RecordNotFound
                render json: { error: 'Cannot find the event.' }, status: 400
            end
        end
    end

    # POST /events
    def create
        @event = Event.new(event_params)
        if @event.save
            render json: { message: 'Event succeessfully store in the database.', event: @event.attributes.slice('id', 'name', 'event_type', 'created_at'), details: JSON.parse(@event[:details])}
        else
            render json: { error: @event.errors.messages }, status: 422
        end
    end

    # PUT /events/:id
    def update
    end

    # DELETE /events/:id
    def destroy
        begin
            @event = Event.find(params[:id])
            id = @event[:id]
            name = @event[:name]
            event_type = @event[:event_type]
            @event.destroy
            json_message = { id: id, name: name, event_type: event_type, deleted: true }
            render json: json_message, status: 200
        rescue ActiveRecord::RecordNotFound
            render json: { error: 'Cannot find the event.' }, status: 400
            # render json: { error: 'Unable to delete Event.' }, status: 400
        end 
    end

    private

    def event_params
        # puts params
        # puts params.as_json
        # puts request.body.read
        puts JSON.parse(params.require(:event).to_json)

        params.require(:event).permit(:name, :event_type).merge({"details": JSON.parse(request.body.read).to_json})
    end
end
