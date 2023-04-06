class HashTagsController < ApplicationController
  before_action :set_tweet, only: [:create]
  def create
    hash_tag = @tweet.hash_tags.create(hash_tag_params)
    render json: {
      hash_tag: hash_tag,
    }
    p hash_tag, hash_tag_params
  end

  private
    def hash_tag_params
      params.require(:hash_tag).permit(:value)
    end

    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end
end
