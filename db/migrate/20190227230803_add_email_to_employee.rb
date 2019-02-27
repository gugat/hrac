class AddEmailToEmployee < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :email, :string
  end
end
