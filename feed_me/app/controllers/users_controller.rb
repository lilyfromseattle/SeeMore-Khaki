class UsersController < ApplicationController


  def create
    @user = User.new(auth_hash)
    raise auth_hash
    if @user.save
      session[:current_user] = @user.id
      redirect_to "/"
    else
      render :signin_path
    end
  end



  private
    def auth_hash
      params.require(request.env['omniauth.auth']).permit(:name, :email, :provider, :uid)
    end
end
