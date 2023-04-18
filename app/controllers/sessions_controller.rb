class SessionsController < ApplicationController

  def create
    user = User.find_by(phone_number: params[:session][:phone_number])
    if user.nil?
      user = User.find_by(email: params[:session][:email])
    end
    if user = User.find_by(password: params[:session][:password])
      render json: {
        user: user
      }
    end
  end
end
