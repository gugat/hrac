class Anomaly < ApplicationRecord

  # Associations
  belongs_to :employee

  # Validations
  validates_presence_of :day 

end
