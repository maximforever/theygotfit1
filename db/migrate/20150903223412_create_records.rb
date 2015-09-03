class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :photo
      t.integer :weight
      t.boolean :pounds
      t.string :caption
      t.datetime :date
      t.references :user
      t.timestamps null: false
    end
  end
end
