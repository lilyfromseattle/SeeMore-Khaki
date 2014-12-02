require "httparty"

class InstagramHelper
  attr_accessor :results_array

  def query_for_users(search_term)
    url = "https://api.instagram.com/v1/users/search?q=#{search_term}&client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}"
    parse(HTTParty.get(url)["data"])
  end

  def query_for_igs(uid, current_user)
    url = "https://api.instagram.com/v1/users/#{uid}/media/recent?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}"
    add_igs_to_db(HTTParty.get(url)["data"], current_user)
  end

  private

    def parse(search_results)
      @results_array = []
      search_results.each { |result| @results_array << user_hash(result) }
    end

    def user_hash(api_hash)
      {
        name:     api_hash["username"],
        avatar:   api_hash["profile_picture"],
        uid:      api_hash["id"],
        service:  "Instagram"
      }
    end

    def add_igs_to_db(api_hash, current_user)
      @results_array = []
      api_hash.each do |ig|
        puts ig.inspect
        post = User.find(current_user).posts.find_by(url_id: ig["link"])
        if post
          @results_array << post
        else
          @results_array << Post.create(
            author_id:  Author.find_by(service: "Instagram", uid: ig["user"]["id"]).id,
            timestamp:  Time.at(ig["created_time"].to_i),
            words:      ig["images"]["thumbnail"]["url"],
            url_id:     ig["link"]
          )
        end
      end
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
