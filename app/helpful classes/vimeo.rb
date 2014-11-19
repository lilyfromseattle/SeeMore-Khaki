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
    @api_data = Vimeo::Simple::User.info(@author).parsed_response
    if @api_data.keys.length >= 21 &&
      #WHAT ABOUT WHEN THE AUTHOR IS ALREADY IN THE AUTHORS DB!??!
      new_author = Author.new(@author)
      new_author.service = "Vimeo"
      new_author.user =
    else
      return "That is not a valid vimeo user name."
    end
  end

end
