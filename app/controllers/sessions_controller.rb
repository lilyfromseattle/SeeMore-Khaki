class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token, only: :create
# otherwise rails clobbers the session because callback is sent as a post request

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    form_hash = auth_hash[:info]

    current_user = User.find_by_provider(auth_hash[:provider], auth_hash[:uid])
    if current_user
      session[:current_user] = current_user.id
      flash.notice = "Welcome back to FeedMe, #{current_user.name}!"
      redirect_to root_path

    else
      user = User.new(name: form_hash[:name],
               email: form_hash[:email],
               provider: auth_hash[:provider],
               uid: auth_hash[:uid])

      if user.save
        session[:current_user] = user.id
        flash.notice = "Thanks for making a FeedMe account, #{user.name}!"
        redirect_to root_path

      else
        render "/auth/:provider"
      end
    end
  end

  def destroy
    user = User.find(session[:current_user])
    session[:current_user] = nil
    flash.notice = "Peace out, #{user.name}!"
    redirect_to root_path
  end

  private

    def new_user_params

    end

end
