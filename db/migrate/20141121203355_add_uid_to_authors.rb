class AddUidToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :uid, :string
  end
end
