class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
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
