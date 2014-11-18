class User < ActiveRecord::Base
  has_many :authors_users
  has_many :authors, through: :authors_users

  def self.find_by_provider(provider, uid)
    self.find_by(provider: provider, uid: uid)
  end
end
