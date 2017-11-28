class CreateScanners < ActiveRecord::Migration[5.1]
  def change
    create_table :scanners do |t|
      t.integer :entry_id
      t.string :name
      t.string :href
      t.string :system

      t.timestamps
    end
  end
end
