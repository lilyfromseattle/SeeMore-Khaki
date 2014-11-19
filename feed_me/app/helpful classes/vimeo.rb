class Vimeo
  def initialize author
    @author = author
    @api_data = []
    @videos = []
    @avatar = author.avatar
  end


  def query_for_vids
    @api_data = Vimeo::Simple::User.videos(@author.name)
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

end
