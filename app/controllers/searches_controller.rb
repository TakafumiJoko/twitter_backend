class SearchesController < ApplicationController
  before_action :set_user, only: [:data]
  def data
    users = @q.result
    render json: {
      users: users,
      # tweets: tweets,
    }
  end

  def tweets
    @tweets = @q.result(distinct: true).includes(:user).order("created_at desc")
  end

  private 
    def user_params
      params.require(:q).permit(:nickname_cont)
    end

    # def search_word_params
    #   params.require(:q).permit()
    # end

    def set_user
      @q = User.ransack(user_params)
    end
end
