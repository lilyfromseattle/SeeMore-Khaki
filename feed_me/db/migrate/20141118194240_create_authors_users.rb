class CreateAuthorsUsers < ActiveRecord::Migration
  def change
    create_table :authors_users do |t|
      t.integer :author_id
      t.integer :user_id

      t.timestamps
    end
  end
end
