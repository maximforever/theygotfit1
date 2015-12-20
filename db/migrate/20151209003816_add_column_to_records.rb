class AddColumnToRecords < ActiveRecord::Migration
  def change
    add_column :records, :other_photos, :text
  end
end
