class ChangeColumnsForUsers < ActiveRecord::Migration
  def change
    add_column :users, :password, :string    
    remove_column :users, :password_digest, :string
  end
end
