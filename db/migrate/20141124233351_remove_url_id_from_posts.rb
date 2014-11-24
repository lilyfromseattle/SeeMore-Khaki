class RemoveUrlIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :url_id, :integer
  end
end
