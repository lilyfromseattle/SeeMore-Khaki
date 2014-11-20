class HomeController < ApplicationController

  def index
  end

  def search
    if params[:service] == "Vimeo"
      @author = VimeoHelper.new(params[:search]).author
    elsif params[:service] == "Instagram"
      @author = InstagramHelper.new(params[:search]).author
    end
  end

  # def subscribed
  #   User
  #   @new_person =
  # end



end
