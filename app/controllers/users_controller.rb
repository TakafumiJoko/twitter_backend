class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update,:destroy]

  def create
    user = User.create(user_params)
    render json: {
      status: :created,
      user: user
    }
  end

  def login
    user = User.find_by(password: user_params[:password])
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

  def show
    render json: {
      status: :showed,
      user: @user
    }
  end

  def update
    @user.update(user_params)
    user = User.find(params[:id])
    render json: {
      status: :updated,
      user: user
    }
  end

  def destroy
    @user.destroy
  end
  
  private
    def user_params
      params.permit(:nickname, :phone_number, :email, :birthday, :password, :introduction, :residence, :website)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
