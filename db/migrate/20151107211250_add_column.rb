class AddColumn < ActiveRecord::Migration
  def change
    add_column :users, :imperial, :boolean
  end
end
