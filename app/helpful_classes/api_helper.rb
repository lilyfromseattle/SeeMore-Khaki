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
      @title = @crap["title"]
      @author = @crap["user_name"]
      @avatar = @crap["user_portrait_medium"]
      @content = @crap["url"]
      @timestamp = @crap["upload_date"]

    elsif @site == "Github"
      @author = @crap["login"]
      @avatar = @crap[""]
      @content = @crap[]
      @url = @crap["url"]
      @timestamp = @crap["created_at"]

    elsif @site == "Instagram"
      #STUFF HAPPENS
    end
    return {site => @site, author => @author, avatar => @avatar, content => @content, url => @url, timestamp => @timestamp}
  end

end
