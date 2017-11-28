class CreateVulnerableSoftwareLists < ActiveRecord::Migration[5.1]
  def change
    create_table :vulnerable_software_lists do |t|
      t.integer :entry_id
      t.string :product

      t.timestamps
    end
  end
end
