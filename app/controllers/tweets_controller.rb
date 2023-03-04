class TweetsController < ApplicationController
  before_action :set_user

  def create
    tweet = @user.tweets.create(tweet_params)
    render json: {
      status: :created,
      tweet: tweet
    }
  end

  private
    def tweet_params
      params.permit(:message, :user_id)
    end

    def set_user
      @user = User.find_by!(id: tweet_params[:user_id])
    end
end
