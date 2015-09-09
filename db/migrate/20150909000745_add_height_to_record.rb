class AddHeightToRecord < ActiveRecord::Migration
  def change
    add_column :records, :height, :integer
    add_column :records, :inches, :boolean

  end
end
