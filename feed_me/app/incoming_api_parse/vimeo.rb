class Vimeo
  def self.query_for_vids(author)
    Vimeo::Simple::User.videos(author)
  end



end
