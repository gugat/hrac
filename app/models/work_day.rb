class WorkDay < ApplicationRecord
  
  # Associations
  belongs_to :employee

  # Validations
  validates_presence_of :total_hours, :day
end
