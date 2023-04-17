class TweetsController < ApplicationController
  before_action :set_user, only: [:create, :index, :reply]
  before_action :set_tweet, only: [:show, :update, :destroy, :replies]
  before_action :set_query, only: [:search]

  def create
    tweet = @user.tweets.create(tweet_params)
    render json: {
      tweet: tweet,
    }
  end

  def show 
    render json: {
      tweet: @tweet
    }
  end

  def index 
    tweets = @user.tweets
    render json: {
      tweets: tweets,
    }
  end

  def update
    @tweet.update(tweet_params)
    tweet = Tweet.find_by(id: params[:id])
    render json: {
      tweet: tweet,
    }
  end

  def destroy
    @tweet.destroy
    render json: {
      tweet: @tweet,
    }
  end

  def search
    tweets = @q.result.order('created_at desc')
    render json: {
      tweets: tweets,
    }
  end

  def reply
    reply = @user.tweets.create(tweet_params)
    replied_id = reply.tweet_relationships.create(replied_id: params[:id]).replied_id
    render json: {
      reply_id: reply.id,
      replied_id: replied_id,
    }
  end

  def replies
    render json: {
      tweets: @tweet.replies
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

    def set_query
      @q = Tweet.ransack(params[:q])
    end

end
