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
      if call_api?(author)
        case author.service
        when "Vimeo"
          z = VimeoHelper.new(author)
          z.query_for_vids
          @posts += z.videos
        when 'Twitter'
          z = TwitterHelper.new(author)
          z.query_for_tweets
          @posts += z.tweets
        when 'Instagram'
          z = InstagramHelper.new
          z.query_for_igs(author.uid, session[:current_user])
          @posts += z.results_array
        when 'Github'
          z = GithubHelper.new(author)
          z.query_for_activities
          @posts += z.activities
        end
        author.update(updated_at: Time.now)
      else
        @posts += author.posts
      end
    end

    @posts.sort_by! { |post| post.timestamp }
    @posts.reverse!

  end

  def call_api?(author)
    call = author.updated_at < Time.now - 3600
    puts "*"*80, "#{call ? "" : "not"} calling API, #{author.name} last updated at #{author.updated_at}, #{(Time.now-author.updated_at)/60} minutes ago"
    call
  end
end
