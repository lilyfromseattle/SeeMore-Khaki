require 'httparty'
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
    puts"****YES WE ARE*******"
    puts "*****FOURRRRR!!!*********************"
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
    end


    @api_data = @client.user_search(@author)
    puts "*****FIVE*********************"

    parse_api
  end

  def parse_api
    puts "*****SIX*********************"

    @api_data = client.user_timeline(@author).take(20)
    puts @api_data.inspect

    @api_data.each_with_index do |tweet, i|
      @tweets << []
      puts "TWEET: #{tweet}*********"
      # avatar = tweet.profile_image_url
      @tweets[i] << author = tweet.user
      puts "USER: #{tweet.user}*********"
      @tweets[i] << text = tweet.text
      puts "TEXT: #{tweet.text}************"
      @tweets[i] << timestamp = tweet.created_at
      # image = tweet.user.image_path

    end
    puts "***********SEVEN*************"
  end

  def query_for_author
    db_or_api
    # The above method searches the db for the author,
    # does api query if author isn't in db
    if @author.class == Author
      @author
    else
      new_author = Author.new(name: @author, service: "Twitter")
      new_author.save
      @author = new_author
    # else
    #   puts "*****FOURTH OPTION*********************"

    end
  end

  def db_or_api
    puts "********ONE***********"
    if Author.find_by(name: @author, service: "Twitter")
      @author = Author.find_by(name: @author, service: "Twitter")
    else
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
      end

      @search_results = @client.user_search(@author).take(20)
      puts "********TWO***********"
      @api_data = @client.user_timeline(@author).take(20)

      @api_data.each_with_index do |tweet, i|
        @tweets << []
        # avatar = tweet.profile_image_url
        @tweets[i] << author = tweet.user
        @tweets[i] << text = tweet.text
        @tweets[i] << timestamp = tweet.created_at
        # image = tweet.user.image_path

      end
      # .hashtags.each.text => [#<Twitter::Entity::Hashtag:0x007fea752a9420 @attrs={:text=>"WHD2013", :indices=>[17, 25]}>, #<Twitter::Entity::Hashtag:0x007fea752a93a8 @attrs={:text=>"EveryMileMatters", :indices=>[108, 125]}>, #<Twitter::Entity::Hashtag:0x007fea752a91c8 @attrs={:text=>"BeyGood", :indices=>[126, 134]}>]
      puts "********THREE***********"
    end


  end
end
