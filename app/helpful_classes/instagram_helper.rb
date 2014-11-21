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
      @results_array << user_hash(result)
    end
  end

  private

    def user_hash(api_hash)
      {
        name:     api_hash["username"],
        avatar:   api_hash["profile_picture"],
        uid:      api_hash["id"],
        service:  "Instagram"
      }
    end
end
