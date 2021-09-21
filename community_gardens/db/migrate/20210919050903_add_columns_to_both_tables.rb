class AddColumnsToBothTables < ActiveRecord::Migration[5.2]
  def change
    add_column :plants, :user_id, :string
    add_column :users, :email, :string
    add_column :users, :password, :string
  end
end
