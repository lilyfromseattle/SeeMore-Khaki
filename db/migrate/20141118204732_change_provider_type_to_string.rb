class ChangeProviderTypeToString < ActiveRecord::Migration
  def change
    change_column :users, :provider, :string
  end
end
