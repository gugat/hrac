class EmployeeAnomaliesService < PowerTypes::Service.new(:employee, :day)

  # Service code goes here
  def initialize(employee, day)
    date_range = (day.beginning_of_day..day.end_of_day)
    @assistances = employee.assistances.where(happening_at: date_range)
    @work_day = employee.work_days.where(day: date_range).first
    @config = Rails.application.config_for(:schedule)
  end

  def absence?
    @assistances.empty?
  end

  def incomplete_assistances?
    @assistances.count.odd?
  end

  def worked_too_short?
    return false unless @work_day
    @work_day.total_hours < @config['min_worked_hours']
  end

  def arrived_late?
    return false if (absence? || !first_entry)
    limit = day_at(first_entry.happening_at, @config['max_arrive_time'])
    first_entry.happening_at > limit
  end
  
  def finished_too_early?
    return false if (absence? || !last_exit)
    limit = day_at(last_exit.happening_at, @config['min_leave_time'])
    last_exit.happening_at < limit
  end

  private 
  
  def first_entry 
    @assistances.where(kind: 'in').first
  end
  
  def last_exit 
    @assistances.where(kind: 'out').last
  end
  
  #
  # Returns a new DateTime with the given time string. Ex: 08H00
  #
  def day_at(day, time_str)
    hour, minute = time_str.split('H')
    day.dup.getlocal.change(hour: hour, min: minute)
  end

end
