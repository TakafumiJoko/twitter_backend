class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :followings]
  before_action :set_query, only: [:search]

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

  def search
    users = @q.result.order('created_at desc')
    render json: {
      users: users
    }
  end
  
  private
    def user_params
      params.require(:user).permit(:nickname, :phone_number, :email, :birthday, :password, :introduction, :residence, :website)
    end

    def search_word_params
      params.require(:q).permit(:nickname_cont)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_query
      @q = User.ransack(search_word_params)
    end
end
