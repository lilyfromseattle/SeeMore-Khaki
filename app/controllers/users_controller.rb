class UsersController < ApplicationController

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

  def instagram_subscribe
    @user = User.find(session[:current_user])
    uid = params[:uid]
    @author = Author.find_by(uid: uid, service: "Instagram")
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
      url = "https://api.instagram.com/v1/users/#{uid}?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}"
      api_hash = HTTParty.get(url)["data"]
      author = Author.new({
        name:     api_hash["username"],
        avatar:   api_hash["profile_picture"],
        uid:      api_hash["id"],
        service:  "Instagram"
        })
      if author.save
        add_and_confirm(author)
      else
        raise "this is probably instagram's fault"
      end
    end

    def add_and_confirm(author)
      @user.authors << author
      flash[:notice] = "You've subscribed to #{author.name} on #{author.service}!"
    end

end
