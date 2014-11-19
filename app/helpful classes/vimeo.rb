class Vimeo
  def initialize author
    @author = author
    @api_data = []
    @videos = []
    @author.class == Author ? @avatar = author.avatar : query_for_author
  end

  def query_for_vids
    @api_data = Vimeo::Simple::User.videos(@author.name).parsed_response
  end

  def parse_api
    @api_data.each do |vid|
      @avatar ||= vid["user_portrait_medium"]
      @videos << {
      title: vid["title"],
      content: vid["url"],
      timestamp: vid["upload_date"] }
    end
  end

  def query_for_author
    db_or_api
    # The above method searches the db for the author, 
    # does api query if author isn't in db
    if @api_data.class == Hash
      new_author = Author.new(@author)
      new_author.service = "Vimeo"
      new_author.save
      return new_author
    else
      return @api_data
    end
  end

  def db_or_api
    if Author.find_by(name: @author, service: "Vimeo").length > 0
      @author = Author.find_by(name: @author, service: "Vimeo")
    else
      @api_data = Vimeo::Simple::User.info(@author).parsed_response
    end
  end

end
