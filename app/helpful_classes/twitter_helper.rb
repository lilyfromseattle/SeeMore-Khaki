require 'httparty'
class TwitterHelper
  attr_accessor :author, :posts
  def initialize author
    @author = author
    @api_data = []
    @posts = []
    @author.class == Author ? @avatar = "blah" : query_for_author
  end

  def query_for_posts
    puts "*****FOURRRRR!!!*********************"
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
    end


    @api_data = client.user_search(@author, lang:'en').take(1)
    puts "*****FIVE*********************"

    parse_api
  end

  def parse_api
    puts "*****SIX*********************"
    @api_data.each do |post|
      @avatar ||= post["user_portrait_medium"]
      @posts << {
      title: post["title"],
      content: post["url"],
      timestamp: post["upload_date"] }
    end
  end

  def query_for_author
    puts "**************#{@author.inspect}"
    db_or_api
    # The above method searches the db for the author,
    # does api query if author isn't in db
    puts "*****TWO**********************"
    puts "******INSPECT OBJ*****#{@api_data.inspect}****************"
    if @author.class == Author
      puts "*****WRONG OPTION*********************"
      @author
    else
      puts "*****THREE*********************"
      new_author = Author.new(name: @author, service: "Twitter")
      new_author.save
      @author = new_author
    # else
    #   puts "*****FOURTH OPTION*********************"

    end
  end

  def db_or_api
    puts "*****ONE********DB OR ABP ##**************"
    if Author.find_by(name: @author, service: "Twitter")
      @author = Author.find_by(name: @author, service: "Twitter")
      puts "THe database stuff happened"
    else
      puts "Looking for API data"

      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
      end



      puts "*****ONE.TWO*******************"
      @api_data = client.user_search(@author, lang:'en').take(1)
      puts "*****gets Client*************"
      puts "****#{@api_data.inspect}*************"
      # @api_data.
    end


  end
end
