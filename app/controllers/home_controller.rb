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
      @author = TwitterHelper.new(params[:search]).author
    end
  end

  # def subscribed
  #   User
  #   @new_person =
  # end



end
