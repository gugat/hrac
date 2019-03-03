class CreateAnomalies < ActiveRecord::Migration[5.1]
  def change
    create_table :anomalies do |t|
      t.boolean :absence
      t.boolean :arrived_late
      t.boolean :worked_too_short
      t.boolean :finished_too_early
      t.boolean :incomplete_assistances
      t.datetime :day
      t.references :employee

      t.timestamps
    end
  end
end
