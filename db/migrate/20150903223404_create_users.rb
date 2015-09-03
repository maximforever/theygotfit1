class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :name
      t.string :username
      t.string :pass
      t.integer :zipcode
      t.boolean :gender
      t.timestamps null: false
      
    end
  end
end
