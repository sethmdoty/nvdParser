class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :cve
      t.string :published_datetime
      t.string :last_modified_datetime
      t.string :summary
      t.string :cwe
      t.string :security_protection

      t.timestamps
    end
  end
end
