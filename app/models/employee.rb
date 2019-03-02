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

  # Validations
  validates_presence_of :first_name, :last_name, :email#, :password

  #
  # Calculate worked hours by day
  # Returns worked hours.
  #
  def calculate_worked_hours(worked_day)
    worked_hours = 0
    assistances_by_day = assistances.where(
      happening_at: worked_day.beginning_of_day..worked_day.end_of_day
    )
    assistances_by_day.each_with_index do |assistance, i|
      date = assistance.happening_at
      worked_hours += (i % 2).zero? ? -date.to_i : date.to_i
    end
    worked_hours / 3600.0
  end
end
