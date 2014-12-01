
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
    @client = Octokit::Client.new :client_id => ENV["GITHUB_CLIENT_ID"], :client_secret => ENV["GITHUB_CLIENT_SECRET"]

    @api_data = @client.user(@author.name)
    puts "API DATA: #{@api_data.inspect}"
    @author.update(avatar: @api_data.avatar_url.to_s)

    unless old_activity = Post.find_by(author_id: @author.id)
      new_activity = Post.new(author_id: @author.id, words: "See my site @ #{@api_data.url}", timestamp: @api_data.created_at)
      if new_activity.save
        @activities << new_activity
      end
    else
      puts "ELSE"
      @activities << old_activity
    end


    # @api_data.each_with_index do |key, array, i|
    #   puts "KEY: #{key}"
    #   puts "ARRAY: #{array}"
    #   puts "i: #{i}"
    #   puts "Can IT GET IN THE EACH?"
    #   unless old_activity = Post.find_by(author_id: @author.id, words: "Nothing to report!")
    #     puts "IN UNLESS"
    #     new_activity = Post.new(
    #       author_id: @author.id,
    #       words: "Nothing to report!",
    #       timestamp: Time.now.to_s
    #     )
    #     if new_activity.save
    #       @activities << new_activity
    #     end
    #   else
    #     puts "ELSE"
    #     @activities << old_activity
    #   end
    # end
  end

  def query_for_author
    db_or_api
    puts "QUESRY FOR AUTHOR"
    if @author.class == Author
      puts "new client"
      @client = Octokit::Client.new :client_id => ENV["GITHUB_CLIENT_ID"], :client_secret => ENV["GITHUB_CLIENT_SECRET"]

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
      @client = Octokit::Client.new :client_id => ENV["GITHUB_CLIENT_ID"], :client_secret => ENV["GITHUB_CLIENT_SECRET"]
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
