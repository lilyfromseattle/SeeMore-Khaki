class FeedController < ApplicationController

  def index
    # Twitter.author
    @feed_content = ApiHelper.all
  end

  def show
    @user = User.find(session[:current_user])
    @authors = @user.authors
    @posts = []
    @authors.each do |author|
      if author.service == "Vimeo"
        z = VimeoHelper.new(author)
        z.query_for_vids
        @posts += z.videos
      elsif author.service == "Twitter"
        z = TwitterHelper.new(author)
        puts "ARE WE QUERYING FOR POSTS?"
        z.query_for_posts

        @posts += z.posts
      end
    end
    @posts.sort_by! { |post| DateTime.parse(post[:timestamp]) }
    @posts.reverse!
  end
end
