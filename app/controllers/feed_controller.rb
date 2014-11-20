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
<<<<<<< HEAD:feed_me/app/controllers/feed_controller.rb
        Vimeo.new(author).query_for_vids.parse_api
      elsif author.service == "Twitter"
        Twitter.new(author).parse_api
      end

=======
        z = VimeoHelper.new(author)
        z.query_for_vids
        @posts += z.videos
      # elsif author.service == "Twitter"
      end
>>>>>>> 85b79a1d08e2e869ae2bc5cae2c6b2337b0e98d4:app/controllers/feed_controller.rb
    end
    @posts.sort_by! { |post| DateTime.parse(post[:timestamp]) }
    @posts.reverse!
  end
end
