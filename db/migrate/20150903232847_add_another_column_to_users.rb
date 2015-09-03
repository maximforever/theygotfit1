class AddAnotherColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
  end
end
