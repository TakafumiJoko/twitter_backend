class HashTagsController < ApplicationController
  before_action :set_category, only: [:index]
  def index
    before_tags = @category.hash_tags.where('created_at >= ?', Time.now - 60 * 60 * 24 * 14).group(:value).count(:value)
    hash_tags = before_tags.map do |tag|
      local_tags = HashTag.where('value = ? and created_at >= ?', tag[0], Time.now - 60 * 60 * 24 * 14)
      tweet_ids = local_tags.map {|t| t[:tweet_id]}
      {value: tag[0], count: tag[1], tweet_ids: tweet_ids}
    end
    render json: {
      hash_tags: hash_tags
    }
  end

  private

    def set_category
      @category = Category.find(params[:category_id])
    end
end
