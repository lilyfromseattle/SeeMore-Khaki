class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token, only: :create
# otherwise rails clobbers the session because callback is sent as a post request (from some APIs)

  def new
    create
  end

  def create
    puts "WE ARE CREATING"
    puts params.inspect
    user = User.find_by_provider(provider, uid)
    if user
      session[:current_user] = user.id
      flash.notice = notice(:signin, user.name)
      redirect_to root_path

    else
      user = User.new(new_user_params)

      if user.save
        session[:current_user] = user.id
        flash.notice = notice(:signup, user.name)
        redirect_to root_path

      else
        render "/auth/#{provider}"
      end
    end
  end

  def destroy
    user = User.find(session[:current_user])
    session[:current_user] = nil
    flash.notice = notice(:signout, user.name)
    redirect_to root_path
  end

  private

    def new_user_params
      {
        name:     name,
        provider: provider,
        uid:      uid
      }
    end

    def auth_hash
      #raise
      request.env['omniauth.auth']
    end

    def api_hash
      auth_hash[:info]
    end

    def provider
      auth_hash[:provider]
    end

    def uid
      auth_hash[:uid]
    end

    def name
      api_hash[:name]
    end

    def notice(action, name)
      case action
      when :signup then "Thanks for making a FeedMe account, #{name}!"
      when :signin then "Welcome back to FeedMe, #{name}!"
      when :signout then "Peace out, #{name}!"
      end
    end

end
