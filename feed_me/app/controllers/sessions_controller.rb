class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token, only: :create
# otherwise rails clobbers the session because callback is sent as a post request

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    form_hash = auth_hash[:info]
    # raise auth_hash.inspect
    current_user = User.find_by_provider(auth_hash[:provider], auth_hash[:uid])
    puts "*"*80, current_user
    if current_user
      session[:current_user] = current_user.id
      redirect_to root_path
    else
      user = User.new(name: form_hash[:name],
               email: form_hash[:email],
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
    session[:current_user] = nil
    redirect_to root_path
  end

  private

    def new_user_params

    end

end
