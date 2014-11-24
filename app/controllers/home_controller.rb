class HomeController < ApplicationController

  def index
  end

  def search
    if params[:service] == "Vimeo"
      @author = VimeoHelper.new(params[:search]).author

    elsif params[:service] == "Instagram"
      @search_term = params[:search]
      @ig_hash = InstagramHelper.new(@search_term)
      @search_results = @ig_hash.results_array

    elsif params[:service] == "Twitter"
      twit = TwitterHelper.new(params[:search])
      @author = twit.author
      @search_results = twit.search_results

    elsif params[:service] == "GitHub"
      @author = GithubHelper.new(@search_term)
    end
  end

end
