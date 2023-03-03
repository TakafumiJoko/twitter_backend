class UsersController < ApplicationController
  def create
    user = User.create(user_params)
    render json: {
      status: :created,
      user: user
    }
  end

  def login
    user = User.find(user_params[:id])
    if user.phone_number && user.phone_number == user_params[:phone_number] 
      render json: {
        status: :logined,
        user: user
      }
    end
    if user.email && user.email == user_params[:email] 
      render json: {
        status: :logined,
        user: user
      }
    end
  end

  private
    def user_params
      params.permit(:id, :nickname, :phone_number, :email, :birthday)
    end
end
