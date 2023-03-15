class ApplicationController < ActionController::API
  def search
    users = User.where(nickname: params[:key]).or(User.where(name: params[:key]))
    render json: {
      status: :searched,
      users: users,
    }
  end
end
