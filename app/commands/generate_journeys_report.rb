class GenerateJourneysReport < PowerTypes::Command.new(:employee, :start_date, :end_date)
  def perform
    # Command code goes here
      assistances = assistances_by_day
      anomalies = anomalies_by_day
      work_days = work_days_by_day
      anomalies.map do |date, _|
        Reports::Journey.new(date, assistances[date], anomalies[date], 
                             work_days[date], @employee)
      end
  end

  private

  def assistances_by_day
    @employee.assistances.by_day(@start_date, @end_date)
                         .group_by { |a| a.happening_at.getlocal.midnight }
  end

  def anomalies_by_day
    @employee.anomalies.by_day(@start_date, @end_date)
                       .order(:day)
                       .group_by { |a| a.day.getlocal.midnight }
  end

  def work_days_by_day  
    @employee.work_days.by_day(@start_date, @end_date)
                       .group_by { |a| a.day.getlocal.midnight } 
  end

end
