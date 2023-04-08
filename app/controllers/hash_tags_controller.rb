class HashTagsController < ApplicationController
  before_action :set_tweet, only: [:create]
  def create
    hash_tag = @tweet.hash_tags.create(hash_tag_params)
    render json: {
      hash_tag: hash_tag,
    }
  end

  def index
    hash_tags = HashTag.where('created_at >= ?', DateTime.now - 14).select(:value, :hash_tag_count).distinct.count
    render json: {
      hash_tags: hash_tags
    }
  end

  private
    def hash_tag_params
      params.require(:hash_tag).permit(:value)
    end

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
end
