# :nodoc:
class Employee < ApplicationRecord

  # Associations
  has_many :assistances

  # Validations
  validates_presence_of :first_name, :last_name
end
