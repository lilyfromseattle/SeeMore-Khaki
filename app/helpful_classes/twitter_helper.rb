class TwitterHelper
  attr_accessor :author, :tweets, :client, :search_results, :api_data
  def initialize author
    @author = author
    @api_data = []
    @tweets = []
    @client = client
    @search_results = search_results
    @author.class == Author ? @avatar = @author.avatar : query_for_author
  end

  def query_for_tweets
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
    end

    @api_data = @client.user_timeline(@author.name).take(1)
    @api_data.each_with_index do |tweet, i|
      @tweets << {
      service: "Twitter",
      user: [tweet.user.name],
      content: [tweet.text],
      timestamp: [tweet.created_at]
      }
    end
  end

  def query_for_author
    db_or_api
    if @author.class == Author
      @author
    else
      new_author = Author.new(name: @author, service: "Twitter")
      new_author.save
      @author = new_author
    end
  end

  def db_or_api
    if Author.find_by(name: @author, service: "Twitter")
      @author = Author.find_by(name: @author, service: "Twitter")
    else
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
      end
      @search_results = @client.user_search(@author).take(1)
      @api_data = @client.user_timeline(@author).take(1)
      @api_data.each_with_index do |tweet, i|
        @tweets << []
        # avatar = tweet.profile_image_url
        @tweets[i] << author = tweet.user
        @tweets[i] << text = tweet.text
        @tweets[i] << timestamp = tweet.created_at
        # image = tweet.user.image_path
      end
      # .hashtags.each.text => [#<Twitter::Entity::Hashtag:0x007fea752a9420 @attrs={:text=>"WHD2013", :indices=>[17, 25]}>, #<Twitter::Entity::Hashtag:0x007fea752a93a8 @attrs={:text=>"EveryMileMatters", :indices=>[108, 125]}>, #<Twitter::Entity::Hashtag:0x007fea752a91c8 @attrs={:text=>"BeyGood", :indices=>[126, 134]}>]
    end

  end
end
