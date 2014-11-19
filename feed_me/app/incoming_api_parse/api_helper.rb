class ApiHelper
  def initialize(crap, site)
   @crap = crap
   @site = site
   @author = set_attributes
   @avatar = avatar
   @content = content
   @url = url
   @timestamp = timestamp
  end

  def set_attributes
    if @site == "Twitter"
      @author = @crap["screen_name"]
      @avatar = @crap["profile_image_url"]
      @content = @crap["text"]
      @url = @crap["source"]
      @timestamp = @crap["created_at"]

    elsif @site == "Vimeo"
      @author = @crap["display_name"]
      @avatar = @crap["portrait_medium"]
      @content = @crap["videos_url"]
      @url = @crap["profile_url"]
      @timestamp = @crap["created_on"]

    elsif @site == "Github"
      @author = @crap["login"]
      @avatar = @crap[""]
      @content = @crap[]
      @url = @crap["url"]
      @timestamp = @crap["created_at"]
    end
    return {site => @site, author => @author, avatar => @avatar, content => @content, url => @url, timestamp => @timestamp}
  end

end
