class StatisticsController < ApplicationController

    # GET /statistics/today
    def index
        # --- Show all statistics --- 
        # @statistics = Statistic.all
        # render json: @statistics

        # --- Show today statistics ---
        d = DateTime.now.strftime("%Y-%m-%d")
        @statistics = Statistic.find_by date: d
        if @statistics != nil
            render json: { date: d, statistics: @statistics.attributes.slice('click', 'view', 'play', 'pause', 'add', 'remove', 'download', 'select', 'load', 'scroll')}
        else
            render json: { date: d, message: 'No record on this day.' }, status: 200
        end
    end

    # GET /statistics/today
    def show    
        if not params[:id] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ or params[:id].length != 8
            render json: { error: 'Date parameter is invalid.' }, status: 400
        else
            temp_date = DateTime.parse(params[:id]).strftime("%Y-%m-%d")
            @statistics = Statistic.find_by(date: temp_date)
            if @statistics != nil
                render json: { date: temp_date, statistics: @statistics.attributes.slice('click', 'view', 'play', 'pause', 'add', 'remove', 'download', 'select', 'load', 'scroll')}
            else
                render json: { date: temp_date, message: 'No record on this day.' }, status: 200
            end
        end
    end

    # def destroy
    #     begin
    #         @s = Statistic.find_by(date: DateTime.parse(params[:id]).strftime("%Y-%m-%d"))
    #         @s.destroy
    #         render json: { deleted: true }, status: 200
    #     rescue ActiveRecord::RecordNotFound
    #         render json: { error: 'Cannot find the date' }, status: 400
    #     end 
    # end
end
