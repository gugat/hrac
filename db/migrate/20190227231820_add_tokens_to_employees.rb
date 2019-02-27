class AddTokensToEmployees < ActiveRecord::Migration[5.1]

  def up
    add_column :employees, :provider, :string, null: false, default: 'email'
    add_column :employees, :uid, :string, null: false, default: ''
    add_column :employees, :tokens, :text

    # if your existing Employee model does not have an existing **encrypted_password** column uncomment below line.
    add_column :employees, :encrypted_password, :string, :null => false, :default => ""

    # the following will update your models so that when you run your migration

    # updates the employee table immediately with the above defaults
    Employee.reset_column_information

    # finds all existing employees and updates them.
    # if you change the default values above you'll also have to change them here below:
    Employee.find_each do |employee|
      employee.uid = employee.email
      employee.provider = 'email'
      employee.save!
    end

    # to speed up lookups to these columns:
    add_index :employees, [:uid, :provider], unique: true
  end

  def down
    # if you added **encrypted_password** above, add here to successfully rollback
    remove_columns :employees, :provider, :uid, :tokens, :encrypted_password
  end
end
