class HomeController < ApplicationController

  def index
  end

  def search
    if params[:service] == "Vimeo"
      @author = VimeoHelper.new(params[:search]).author

    end
  end



end
