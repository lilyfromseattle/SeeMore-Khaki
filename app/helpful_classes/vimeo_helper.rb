class VimeoHelper
  attr_accessor :author, :videos
  def initialize author
    @author = author
    @api_data = ""
    @videos = []
    @author.class == Author ? @avatar = "blah" : query_for_author
  end

  def query_for_vids
    @api_data = Vimeo::Simple::User.videos(@author.name).parsed_response
    parse_api
  end

  def parse_api
    @api_data.each do |vid|
      @avatar ||= vid["user_portrait_medium"]
      puts vid["url"]
      @videos << {
      service: "Vimeo",
      title: vid["title"],
      content: /\d+/.match(vid["url"]),
      timestamp: vid["upload_date"] }
    end
  end

  def query_for_author
    db_or_api
    # The above method searches the db for the author,
    # does api query if author isn't in db
    if @author.class == Author
      @author
    elsif @api_data.class == Hash
      new_author = Author.new(name: @author, service: "Vimeo")
      new_author.save
      @author = new_author
    else
      @author = @api_data
    end
  end

  def db_or_api
    if Author.find_by(name: @author, service: "Vimeo")
      @author = Author.find_by(name: @author, service: "Vimeo")
      puts "THe database stuff happened"
    else
      puts "Looking for API data"
      if /\s/.match(@author)
        @api_data = "That is not a valid username."
      else
        @api_data = Vimeo::Simple::User.info(@author).parsed_response
      end
    end
  end

end
