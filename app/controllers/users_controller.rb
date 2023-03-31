class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def create
    user = User.create(user_params)
    render json: {
      user: user,
    }
  end

  def login
    user = User.find_by(password: user_params[:password])
    # if user && user.authenit
    if user.phone_number && user.phone_number == user_params[:phone_number] 
      render json: {
        user: user
      }
    end
    if user.email && user.email == user_params[:email] 
      render json: {
        user: user
      }
    end
  end

  def show
    render json: {
      user: @user,
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
  
  private
    def user_params
      params.require(:user).permit(:nickname, :phone_number, :email, :birthday, :password, :introduction, :residence, :website)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
