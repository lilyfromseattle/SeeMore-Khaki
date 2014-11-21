class AddAvatarColumnToAuthorsTable < ActiveRecord::Migration
  def change
    add_column :authors, :avatar, :string
  end
end
