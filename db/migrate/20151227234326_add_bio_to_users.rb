class AddBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio_do, :text
    add_column :users, :bio_eat, :text
    add_column :users, :bio_about, :text
  end
end
