class RelationshipsController < ApplicationController
  before_action :set_user
  def create
    @user.follow(params[:followed_id])
    render json: {
      followed_id: params[:followed_id]
    }
  end
  def destroy
    @user.unfollow(params[:followed_id])
    render json: {
      followed_id: params[:followed_id]
    }
  end
  def followings
    users = @user.followings
    render json: {
      followings: users
    }
  end
  def followers
    @users = @user.followers
    render json: {
      followers: @users
    }
  end

  private
    def set_user
      @user = User.find(params[:username])
    end
end
