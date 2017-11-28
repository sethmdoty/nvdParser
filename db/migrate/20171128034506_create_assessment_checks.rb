class CreateAssessmentChecks < ActiveRecord::Migration[5.1]
  def change
    create_table :assessment_checks do |t|
      t.integer :entry_id
      t.string :name
      t.string :href
      t.string :system

      t.timestamps
    end
  end
end
