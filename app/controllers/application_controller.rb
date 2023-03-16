class ApplicationController < ActionController::API
  def search
    users = User.where(nickname: params[:key]).or(User.where(name: params[:key]))
    searched_tweets = Tweet.where("message LIKE ?", "%#{params[:key]}%")
    render json: {
      status: :searched,
      users: users,
      tweets: searched_tweets,
    }
  end
end
