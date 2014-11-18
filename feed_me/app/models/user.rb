class User < ActiveRecord::Base

  def self.find_by_provider(provider, uid)
    self.find_by(provider: provider, uid: uid)
  end
end
