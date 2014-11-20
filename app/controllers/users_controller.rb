class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(auth_hash)
    raise auth_hash
    if @user.save
      session[:current_user] = @user.id
      redirect_to "/"
    else
      render :developer_signin_path
    end
  end

  def subscribe
    @user = User.find(session[:current_user])
    @author = Author.find(params[:id])
    @authors_user = AuthorsUser.new
    @authors_user.author_id = @author.id
    @authors_user.user_id = session[:current_user]
    # redirect_to "/users/#{session[:current_user]}/feed"
    if @authors_user.save
      flash[:notice] = "You are now subscribed to #{@author.name}!"
      # redirect_to "/home/subscribed"
      redirect_to "/users/#{session[:current_user]}/feed"
    end

  end



  private
    def auth_hash
      params.require(request.env['omniauth.auth']).permit(:name, :email, :provider, :uid)
    end

end
