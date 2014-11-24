class GithubHelper

  attr_accessor :author, :activities, :search_results, :api_data, :results_array

  def initialize author
    url = "https://api.github.com/v1/users/search?q=#{search_term}&client_id=#{ENV["GITHUB_CLIENT_ID"]}"
    parse(HTTParty.get(url)["data"])

    @author = author
    @api_data = []
    @activities = []
    @client = client
    @search_results = search_results
    @author.class == Author ? @avatar = @author.avatar : query_for_author
  end

  def query_for_activities

    @api_data = user_timeline(@author.name).take(5)
    @api_data.each_with_index do |activity, i|
      @activities << {
      service: "Github",
      user: [activity.user.name],
      content: [activity.text],
      timestamp: [activity.created_at]
      }
    end
  end

  def query_for_author
    db_or_api
    if @author.class == Author
      @author

      @search_results = @client.user_search(@author.name).take(10)
    else
      new_author = Author.new(name: @author, service: "Github")
      new_author.save
      @author = new_author
    end
  end

  def db_or_api
    if Author.find_by(name: @author, service: "Github")
      @author = Author.find_by(name: @author, service: "Github")
      "IS IT FINDING IT BY NAME?"
    else

      @search_results = @client.user_search(@author).take(10)
      @api_data.each_with_index do |activity, i|
        @activities << []
        # avatar = activity.profile_image_url
        @activities[i] << author = activity.user
        @activities[i] << text = activity.text
        @activities[i] << timestamp = activity.created_at
        # image = activity.user.image_path
      end
      # .hashtags.each.text => [#<Github::Entity::Hashtag:0x007fea752a9420 @attrs={:text=>"WHD2013", :indices=>[17, 25]}>, #<Github::Entity::Hashtag:0x007fea752a93a8 @attrs={:text=>"EveryMileMatters", :indices=>[108, 125]}>, #<Github::Entity::Hashtag:0x007fea752a91c8 @attrs={:text=>"BeyGood", :indices=>[126, 134]}>]
    end

  end
end
