
class GithubHelper
  attr_accessor :author, :activities, :client, :search_results, :api_data
  def initialize author
    @author = author
    @api_data = []
    @activities = []
    @client = client
    @search_results = search_results
    (@author.class == Author) ? (@avatar = @author.avatar) : query_for_author
  end

  def query_for_activities
    puts "IS THIS QUERY EVER CALLED?"
    @client = Octokit::Client.new(:access_token => "8cc24e088e03f0a44003bac6571e77d9f6d33b45")

    @api_data = @client.search_users(@author.name)
    @author.update(avatar: @api_data.items[0].avatar_url.to_s)
    @api_data.each_with_index do |activity, i|
      unless old_activity = Post.find_by(author_id: @author.id, words: "Nothing to report!")
        new_activity = Post.new(
          author_id: @author.id,
          words: "Nothing to report!",
          timestamp: Time.now.to_s
        )
        if new_activity.save
          @activities << new_activity
        end
      else
        @activities << old_activity
      end
    end
  end

  def query_for_author
    db_or_api
    puts "QUESRY FOR AUTHOR"
    if @author.class == Author
      puts "new client"
      @client = Octokit::Client.new(:access_token => "8cc24e088e03f0a44003bac6571e77d9f6d33b45")

      @search_results = @client.search_users(@author)
    else
      puts "AUTHOR CLASS"
      new_author = Author.new(name: @author, service: "Github")
      new_author.save
      @author = new_author
    end
  end
  #
  def db_or_api
    if Author.find_by(name: @author, service: "Github")
      @author = Author.find_by(name: @author, service: "Github")
      puts "NEW AUTHOR"
    else
      puts "OR NEW CLIENT"
      @client = Octokit::Client.new(:access_token => "8cc24e088e03f0a44003bac6571e77d9f6d33b45")
      # User.find_by_user_id(session[:user_id])

      @search_results = @client.search_users(@author)
      puts "SEARCH RESULTS: #{@search_results.inspect}"
      @api_data.each_with_index do |activity, i|
        @activities << []
          puts "IS IT DOING THIS? #{activity.user}"
          @activities[i] << author = activity.user
          @activities[i] << text = activity.text
          @activities[i] << timestamp = activity.created_at
        # @activities[i] << author = @search_results.items[0].login
        # puts "**1**"
        # puts @search_results.items[0].login
        # @activities[i] << text = @search_results.items[0].received_events_url
        # puts "**2**"
        # puts @search_results.items[0].received_events_url
        # @activities[i] << timestamp = activity.created_at

      end

    end

  end
end
