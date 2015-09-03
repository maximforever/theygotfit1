class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pass_confirm, :string
  end
end
