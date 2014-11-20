class HomeController < ApplicationController

  def index
  end

  def search
    if params[:service] == "Vimeo"
      @author = VimeoHelper.new(params[:search]).author
    elsif params[:service] == "Instagram"
      @search_results = InstagramHelper.new(params[:search]).results_array
    end
  end

  # def subscribed
  #   User
  #   @new_person =
  # end



end
