
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
    @client = Octokit::Client.new :client_id => ENV["GITHUB_CLIENT_ID"], :client_secret => ENV["GITHUB_CLIENT_SECRET"]
    @api_data = @client.user(@author.name)
    @author.update(avatar: @api_data.avatar_url.to_s)
    unless old_activity = Post.find_by(author_id: @author.id)
      new_activity = Post.new(author_id: @author.id, words: "See my site @ #{@api_data.url}", timestamp: @api_data.created_at)
      if new_activity.save
        @activities << new_activity
      end
    else
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
    if @author.class == Author
      @client = Octokit::Client.new :client_id => ENV["GITHUB_CLIENT_ID"], :client_secret => ENV["GITHUB_CLIENT_SECRET"]
      @search_results = @client.search_users(@author)
    else
      new_author = Author.new(name: @author, service: "Github")
      new_author.save
      @author = new_author
      query_for_activities # added this line to initialize a new author with an initial API call to load posts into DB (else will not appear in feed because timestamp is within last hour)
    end
  end
  #
  def db_or_api
    if Author.find_by(name: @author, service: "Github")
      @author = Author.find_by(name: @author, service: "Github")
    else
      @client = Octokit::Client.new :client_id => ENV["GITHUB_CLIENT_ID"], :client_secret => ENV["GITHUB_CLIENT_SECRET"]
      @search_results = @client.search_users(@author)
      @api_data.each_with_index do |activity, i|
        @activities << []
          @activities[i] << author = activity.user
          @activities[i] << text = activity.text
          @activities[i] << timestamp = activity.created_at
      end
    end
  end
end
