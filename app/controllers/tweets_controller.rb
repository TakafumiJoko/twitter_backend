class TweetsController < ApplicationController
  before_action :set_user, only: [:create, :index, :reply]
  before_action :set_tweet, only: [:show, :update, :destroy, :replies, :hash_tag]
  before_action :set_query, only: [:search]

  def create
    params = tweet_params
    params[:images] = params[:images].to_h.map {|k, v| v}
    tweet = @user.tweets.create(params)
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
    p tweets
    render json: {
      tweets: tweets,
    }
  end

  def update
    @tweet.update(tweet_params)
    tweet = Tweet.find_by(id: params[:username])
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
    replied_id = reply.tweet_relationships.create(replied_id: params[:username]).replied_id
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

  def hash_tag
    render json: {
      tweet: @tweet
    }
  end

  private
    def tweet_params
      params.require(:tweet).permit(:message, images: {})
    end

    def set_user
      @user = User.find_by(name: params[:username])
    end

    def set_tweet
      @tweet = Tweet.find_by(id: params[:username])
    end

    def set_query
      @q = Tweet.ransack(params[:q])
    end

end
