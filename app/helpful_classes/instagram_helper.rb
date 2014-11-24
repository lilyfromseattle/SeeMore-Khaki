require "httparty"

class InstagramHelper
  attr_accessor :results_array

  def query_for_users(search_term)
    url = "https://api.instagram.com/v1/users/search?q=#{search_term}&client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}"
    parse(HTTParty.get(url)["data"], :users)
  end

  def query_for_igs(uid)
    url = "https://api.instagram.com/v1/users/#{uid}/media/recent?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}"
    parse(HTTParty.get(url)["data"], :igs)

  end

  private

    def parse(search_results, search_type)
      @results_array = []
      search_results.each do |result|
        if search_type == :users
          @results_array << user_hash(result)
        elsif search_type == :igs
          @results_array << ig_hash(result)
        end
      end
    end

    def user_hash(api_hash)
      {
        name:     api_hash["username"],
        avatar:   api_hash["profile_picture"],
        uid:      api_hash["id"],
        service:  "Instagram"
      }
    end

    def ig_hash(api_hash)
      {
        service:    "Instagram",
        timestamp:  Time.at(api_hash["created_time"].to_i),
        url:        api_hash["link"],
        image:      api_hash["images"]["thumbnail"],
        author:     api_hash["user"]["username"],
        show_name:  api_hash["user"]["full_name"],
        caption:    api_hash["caption"] ? api_hash["caption"]["text"] : nil
      }
    end
end
