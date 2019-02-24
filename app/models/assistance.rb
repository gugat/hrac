# :nodoc:
class Assistance < ApplicationRecord

  # Associations
  belongs_to :employee

  # Validations
  validates_presence_of :entry, :exit
end
