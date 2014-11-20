class TwitterHelper
  attr_accessor :author, :posts
  def initialize author
    @author = author
    @api_data = []
    @posts = []
    @author.class == Author ? @avatar = "blah" : query_for_author
  end

  def query_for_posts
    @api_data = HTTParty.get('http://twitter.com/statuses/public_timeline.json')
    parse_api
  end

  def parse_api
    @api_data.each do |post|
      @avatar ||= post["user_portrait_medium"]
      @posts << {
      title: post["title"],
      content: post["url"],
      timestamp: post["upload_date"] }
    end
  end

  def query_for_author
    db_or_api
    # The above method searches the db for the author,
    # does api query if author isn't in db
    if @author.class == Author
      @author
    elsif @api_data.class == Hash
      new_author = Author.new(name: @author, service: "Twitter")
      new_author.save
      @author = new_author
    else
      @author = @api_data
    end
  end

  def db_or_api
    if Author.find_by(name: @author, service: "Twitter")
      @author = Author.find_by(name: @author, service: "Twitter")
      puts "THe database stuff happened"
    else
      puts "Looking for API data"
      @api_data = Twitter::Simple::User.info(@author).parsed_response
    end
  end

end
