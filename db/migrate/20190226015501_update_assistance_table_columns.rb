class UpdateAssistanceTableColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :assistances, :entry, :datetime
    remove_column :assistances, :exit, :datetime
    add_column :assistances, :happening_at, :datetime
  end
end
