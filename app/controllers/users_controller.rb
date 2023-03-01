class UsersController < ApplicationController
  def create
    user = User.create(user_params)
    render json: {
      status: :created,
      user: user
    }
  end

  private
    def user_params
      params.permit(:nickname, :phone_number, :email, :birthday)
    end
end
