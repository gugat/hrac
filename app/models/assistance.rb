# :nodoc:
class Assistance < ApplicationRecord

  # Calculate worked hours for every assistance of kind 'out' saved
  after_save :set_worked_hours

  enum kind: {
    out: 'out',
    in: 'in'
  }

  # Associations
  belongs_to :employee

  # Validations
  validates_presence_of :happening_at, :kind

  #
  # Create or update a WorkDay
  #
  def set_worked_hours
    if out?
      worked_hours = employee.calculate_worked_hours(happening_at)
      workday = WorkDay.where(day: happening_at.midnight..happening_at.end_of_day)
      WorkDay.create!(employee: employee, total_hours: worked_hours, day: happening_at)
      if workday.empty?
        WorkDay.create!(employee: employee, total_hours: worked_hours, day: happening_at)
      else
        workday.first.update(total_hours: worked_hours)
      end
    end
  end

end
