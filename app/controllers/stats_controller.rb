class StatsController < ApplicationController

    # GET /stats/
    def index
        @stats = Event.where("created_at BETWEEN ? AND ?", DateTime.now.beginning_of_day, DateTime.now.end_of_day).all.group(:event_type).count
        render json: { todays_stats: @stats}
    end


    # GET /stats/:date
    def show
        if not params[:id] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ or params[:id].length != 8
            render json: { error: 'Date parameter is invalid.' }, status: 400
        else
            temp_date = DateTime.parse(params[:id])
            @stat = Event.where("created_at BETWEEN ? AND ?", temp_date.beginning_of_day, temp_date.end_of_day).all.group(:event_type).count
            render json: { date: temp_date.strftime("%Y-%m-%d") , stats: @stat}
        end
    end
end
