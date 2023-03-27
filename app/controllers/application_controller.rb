class ApplicationController < ActionController::Base
  def search
    users = User.where(nickname: params[:key]).or(User.where(name: params[:key]))
    searched_tweets = Tweet.where("message LIKE ?", "%#{params[:key]}%")
    p searched_tweets
    render json: {
      users: users,
      tweets: searched_tweets,
    }
  end
end
