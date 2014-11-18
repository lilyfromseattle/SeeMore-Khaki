class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  # otherwise rails clobbers the session because callback is sent as a post request

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/"
    else
      render "auth/developer"
    end
  end

  private
    def user_params
      params.permit(:name, :email)
    end
end
