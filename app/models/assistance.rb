# :nodoc:
class Assistance < ApplicationRecord

  enum kind: {
    out: 'out',
    in: 'in'
  }

  # Associations
  belongs_to :employee

  # Validations
  validates_presence_of :happening_at, :kind
end
