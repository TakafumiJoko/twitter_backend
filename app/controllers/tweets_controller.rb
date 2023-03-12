class TweetsController < ApplicationController
  before_action :set_user, only: [:create, :index]
  before_action :set_tweet, only: [:update, :destroy]

  def create
    tweet = @user.tweets.create(tweet_params)
    render json: {
      status: :created,
      tweet: tweet,
    }
  end

  def index 
    tweets = @user.tweets
    render json: {
      status: :indexed,
      tweets: tweets,
    }
  end

  def update
    @tweet.update(tweet_params)
    tweet = Tweet.find_by(id: params[:id])
    render json: {
      status: :updated,
      tweet: tweet,
    }
  end

  def destroy
    @tweet.destroy
    render json: {
      status: :destroyed,
    }
  end

  private
    def tweet_params
      params.require(:tweet).permit(:message)
    end

    def set_user
      @user = User.find_by(id: params[:user_id])
    end

    def set_tweet
      @tweet = Tweet.find_by(id: params[:id])
    end
end
