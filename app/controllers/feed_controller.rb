class FeedController < ApplicationController

  def index
    # Twitter.author
    @feed_content = ApiHelper.all
    raise
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

        z.query_for_tweets

        @posts += z.tweets
      elsif author.service == "Instagram"
        z = InstagramHelper.new
        z.query_for_igs(author.uid)
        @posts += z.results_array
      end
    end

    @posts.sort_by! { |post| post['timestamp'].nil? ? DateTime.new : DateTime.parse(post['timestamp']) }
    @posts.reverse!
    # raise @posts.inspect
  end
end
