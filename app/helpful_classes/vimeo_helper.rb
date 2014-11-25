class VimeoHelper
  attr_accessor :author, :videos
  def initialize author
    @author = author
    @api_data = ""
    @videos = []
    @author.class == Author ? @avatar = @author.avatar : query_for_author
  end

  def query_for_vids
    query_db_for_vids
    @api_data = Vimeo::Simple::User.videos(@author.name).parsed_response
    parse_api
  end

  def query_db_for_vids
    vids = Post.where(author_id: @author.id)
    vids.each do |vid|
      @videos << vid
    end
  end

  def parse_api
    @api_data.each do |vid|
      @author.avatar ||= vid["user_portrait_medium"]
      unless old_post = Post.find_by(url_id: /\d+/.match(vid["url"]).to_s)
        new_post = Post.new(
          author_id: @author.id,
          words: vid["title"],
          url_id: /\d+/.match(vid["url"]).to_s.to_i,
          timestamp: vid["upload_date"] )
        if new_post.save
          @videos << new_post
        end
      else
        @videos << old_post
      end
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
