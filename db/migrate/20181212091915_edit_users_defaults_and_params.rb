class EditUsersDefaultsAndParams < ActiveRecord::Migration[5.2]
  def change

    change_column_default(:users, :admin, false)
    remove_index :users, :user_name
    add_index :users, :user_name
  
  end
end
