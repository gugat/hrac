# :nodoc:
class Employee < ApplicationRecord

  enum role: [:staff, :admin]
            # Include default devise modules.
            devise :database_authenticatable, :registerable#,
                #     :recoverable, :rememberable, :trackable, :validatable,
                #     :confirmable, :omniauthable
            include DeviseTokenAuth::Concerns::User

  # Associations
  has_many :assistances
  has_many :work_days
  has_many :anomalies

  # Validations
  validates_presence_of :first_name, :last_name, :email#, :password


end
