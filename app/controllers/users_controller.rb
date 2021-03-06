class UsersController < ApplicationController
  def subscribe
    @user = User.find(session[:current_user])
    @author = Author.find(params[:id])
    puts "WE ARE HERE 111"
    if AuthorsUser.where(user_id: @user.id, author_id: @author.id) != []
      puts "AUTHORS USER  222"
      flash[:notice] = "You are already subscribed to #{@author.name} on #{@author.service}!"

      # redirect_to "/home/subscribed"
      if ! request.xhr?
        puts "*******3333********"
        redirect_to "/users/#{session[:current_user]}/feed"
      else
        puts "*******44444********"
        render :json => @author
      end
    else
      puts "NEW AUTHOR_USER 333"
      @authors_user = AuthorsUser.new
      @authors_user.author_id = @author.id
      @authors_user.user_id = session[:current_user]
      # redirect_to "/users/#{session[:current_user]}/feed"
      if @authors_user.save
        puts "*******5555********"
        flash[:notice] = "You are now subscribed to #{@author.name} on #{@author.service}!"

        # redirect_to "/home/subscribed"
        if ! request.xhr?
          puts "*******66666********"
          redirect_to "/users/#{session[:current_user]}/feed"
        else
          puts "*******7777********"
          render :json => @author
        end
      end
    end
  end

  def instagram_subscribe
    @user = User.find(session[:current_user])
    uid = params[:uid]
    @author = Author.find_by(uid: uid, service: 'Instagram')
    if @author
      unless @user.authors.include? @author
        add_and_confirm(@author)
      else
        flash[:notice] = "You're already subscribed to #{@author.name} on Instagram."
      end
    else
      add_instagram_user(uid)
    end
    redirect_to "/users/#{@user.id}/feed"
  end

  private

  def add_instagram_user(uid)
    url = "https://api.instagram.com/v1/users/#{uid}?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}"
    api_hash = HTTParty.get(url)
    if api_hash['meta']['code'] == 200
      api_hash = api_hash['data']
      author = Author.new({
        name:     api_hash["username"],
        avatar:   api_hash["profile_picture"],
        uid:      api_hash["id"],
        service:  "Instagram"
        })
      if author.save
        add_and_confirm(author)
        InstagramHelper.new.query_for_igs(author.uid, @user.id)
      else
        raise "this is probably instagram's fault"
      end
    else
      flash[:notice] = "Fail :( Maybe this account is private?"
    end
  end

  def add_and_confirm(author)
    @user.authors << author
    flash[:notice] = "You're subscribed to #{author.name} on #{author.service}!"
  end

end
