class StatsController < ApplicationController

    # GET /stats/
    def index
        @events = Event.where("created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
        render json: @events
    end


    # GET /stats/:date
    def show
        @events = Event.where("created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
        render json: @events
    end
end
