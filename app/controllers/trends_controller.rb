class TrendsController < ApplicationController
  def index
    trends = Category.find!(params[:category_id]).trends
    render json: {
      trends: trends,
    }
  end
end
