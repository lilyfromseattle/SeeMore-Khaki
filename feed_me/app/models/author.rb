class Author < ActiveRecord::Base
  has_many :authors_users
  has_many :users, through: :authors_users
end
