class RemoveOldPassFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :pass, :string
    remove_column :users, :pass_confirm, :string
  end
end
