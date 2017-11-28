class CreateCvsses < ActiveRecord::Migration[5.1]
  def change
    create_table :cvsses do |t|
      t.integer :entry_id
      t.string :score
      t.string :access_vector
      t.string :access_complexity
      t.string :authentication
      t.string :confidentiality_impact
      t.string :integrity_impact
      t.string :availability_impact
      t.string :source
      t.string :generated_on_datetime

      t.timestamps
    end
  end
end
