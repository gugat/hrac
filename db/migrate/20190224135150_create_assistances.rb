class CreateAssistances < ActiveRecord::Migration[5.1]
  def change
    create_table :assistances do |t|
      t.datetime :entry
      t.datetime :exit
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
