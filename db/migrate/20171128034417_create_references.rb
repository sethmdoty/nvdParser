class CreateReferences < ActiveRecord::Migration[5.1]
  def change
    create_table :references do |t|
      t.integer :entry_id
      t.string :source
      t.string :ref_type
      t.string :reference
      t.string :href
      t.string :language

      t.timestamps
    end
  end
end
