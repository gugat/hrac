# :nodoc:
class Employee < ApplicationRecord
            # Include default devise modules.
            devise :database_authenticatable, :registerable#,
                #     :recoverable, :rememberable, :trackable, :validatable,
                #     :confirmable, :omniauthable
            include DeviseTokenAuth::Concerns::User

  # Associations
  has_many :assistances

  # Validations
  validates_presence_of :first_name, :last_name
end
