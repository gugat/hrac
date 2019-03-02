class CreateWorkDays < ActiveRecord::Migration[5.1]
  def change
    create_table :work_days do |t|
      t.datetime :day
      t.float :total_hours
      
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
