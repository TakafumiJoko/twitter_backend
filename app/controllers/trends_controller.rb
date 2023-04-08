class TrendsController < ApplicationController
  before_action :set_trend, only: [:update]
  def index
    trends = Trend.all
    render json: {
      trends: trends
    }
  end

  def create
    Trend.create()
  end

  def update
    trend = @trend.increment!(:count, 1)  
    render json: {
      trend: trend
    }
  end

  private
    def hash_tag_params
      params.require(:hash_tag).permit(:value)
    end

    def set_trend
      @trend = Trend.find(params[:id])
    end
end
