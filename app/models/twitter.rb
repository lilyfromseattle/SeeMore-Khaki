require 'httparty'

class Twitter < ActiveRecord::Base

  attr_accessor :author

  def initialize(author)
    @author = author
  end

  #Using HTTParty to get and parse a JSON request
  def self.author
    HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=#{author}").parsed_response
  end

end
