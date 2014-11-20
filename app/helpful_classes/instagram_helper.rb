require "httparty"

class InstagramHelper
  attr_accessor :author

  def initialize(author)
    find_by_author
  end

  def find_by_author
    found_author = Author.find_by(name: @author, service: "Instagram")
    if found_author
      @author = found_author
    else
      @author = Author.create(name: @author, service: "Instagram")
    end
  end

end
