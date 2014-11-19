class User < ActiveRecord::Base

  has_many :authors_users
  has_many :authors, through: :authors_user

  # has_and_belongs_to_many :authors


  validates :email, presence: true
  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true

  def self.find_by_provider(provider, uid)
    self.find_by(provider: provider, uid: uid)
  end
end
