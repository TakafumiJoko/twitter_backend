class TweetsController < ApplicationController
  before_action :set_user, only: [:create]
  before_action :set_tweet, only: [:destroy]

  def create
    tweet = @user.tweets.create(tweet_params)
    render json: {
      status: :created,
      tweet: tweet,
    }
  end

  def destroy
    @tweet.destroy
    tweet = Tweet.find_by(id: params[:id])
    render json: {
      status: :destroyed,
    }
  end

  private
    def tweet_params
      params.permit(:message)
    end

    def set_user
      @user = User.find_by(id: params[:user_id])
    end

    def set_tweet
      @tweet = Tweet.find_by(id: params[:id])
    end
end
