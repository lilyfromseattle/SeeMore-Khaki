class AddUrlIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :url_id, :string
  end
end
