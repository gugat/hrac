# :nodoc:
class Assistance < ApplicationRecord

  # Callbacks
  # Calculate worked hours for every assistance of kind 'out' saved
  after_save :set_worked_hours

  # Scopes
  scope :by_day, ->(start_date, end_date) {
    where(happening_at: start_date.beginning_of_day...end_date.end_of_day) }
    
  # Enums
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
      hours = CalculateWorkedHours.for(employee: employee, day: happening_at)
      date = happening_at.getlocal.midnight
      work_day = WorkDay.find_or_initialize_by(day: date, employee: employee)
      work_day.update(total_hours: hours)                              
    end
  end

end
