class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :followings]
  before_action :set_query, only: [:search]

  def create
    user = User.create(user_params)
    p 7, user
    render json: {
      user: user,
    }
  end

  def show
    p @user
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
    user = User.find(params[:username])
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

  def search
    users = @q.result.order('created_at desc')
    render json: {
      users: users
    }
  end
  
  private
    def user_params
      params.require(:user).permit(:nickname, :phone_number, :email, :birthday, :password, :introduction, :residence, :website, :avatar)
    end

    def search_word_params
      params.require(:q).permit(:nickname_cont)
    end

    def set_user
      @user = User.find_by(name: params[:username])
    end

    def set_query
      @q = User.ransack(search_word_params)
    end
end
