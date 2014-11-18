class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token, only: :create
# otherwise rails clobbers the session because callback is sent as a post request

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if current_user = User.find_by_provider(auth_hash[:provider], auth_hash[:uid])
      session[:current_user] = current_user.id
      redirect_to root_path
    else
      user = User.new(name: auth_hash[:name],
               email: auth_hash[:email],
               provider: auth_hash[:provider],
               uid: auth_hash[:uid])
      if user.save
        session[:current_user] = user.id
        redirect_to root_path
      else
        render "/auth/developer"
      end     
    end
  end

  def destroy

  end
end
