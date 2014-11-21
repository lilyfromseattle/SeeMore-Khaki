require "httparty"

class InstagramHelper
  attr_accessor :results_array

  def initialize(search_term)
    url = "https://api.instagram.com/v1/users/search?q=#{search_term}&client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}"
    parse(HTTParty.get(url)["data"])
  end

  def parse(search_results)
    @results_array = []
    search_results.each do |result|
      @results_array << {
        name:     result["username"],
        avatar:   result["profile_picture"],
        uid:      result["id"],
        service:  "Instagram"
      }
    end
  end

  def subscribe(author)
    Author.new(name: author.name, service: author.service)
  end
end
