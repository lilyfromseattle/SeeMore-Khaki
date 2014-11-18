class FeedController < ApplicationController

  def index
    Twitter.author
  end
end
