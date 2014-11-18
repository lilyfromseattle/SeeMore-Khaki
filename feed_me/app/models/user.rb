class User < ActiveRecord::Base
  has_many :authors_users
  has_many :authors, through: :authors_users
end
