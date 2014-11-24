class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :timestamp
      t.integer :url_id
      t.string :words

      t.timestamps
    end
  end
end
