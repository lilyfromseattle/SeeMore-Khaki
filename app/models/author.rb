class Author < ActiveRecord::Base
  has_many :authors_users
  has_many :users, through: :authors_user
  # has_and_belongs_to_many :users
end
