class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :followings]

  def create
    user = User.create(user_params)
    render json: {
      user: user,
    }
  end

  def show
    render json: {
      user: @user,
    }
  end

  def index
    users = User.all
    render json: {
      users: users
    }
  end

  def update
    @user.update(user_params)
    user = User.find(params[:id]) 
    render json: {
      user: user,
    }
  end

  def destroy
    @user.destroy
    render json: {
      user: @user,
    }
  end

  def followings
    render json: {
      followings: @user.followings
    }
  end
  
  private
    def user_params
      params.require(:user).permit(:nickname, :phone_number, :email, :birthday, :password, :introduction, :residence, :website)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
