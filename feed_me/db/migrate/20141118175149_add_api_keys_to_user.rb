class AddApiKeysToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :text
    add_column :users, :uid, :integer
  end
end
