module Reports
  class Journey

    attr_accessor :id, :day, :assistances, :anomalies, :worked_hours, :employee

    def initialize(day, assistances, anomalies, work_days, employee)
      @day = day.to_date.iso8601
      @assistances = assistances
      @anomalies = anomalies
      @worked_hours = work_days.first.total_hours
      @employee = employee
      @id = generate_id
    end

    private
    def generate_id
      Digest::MD5.hexdigest(@employee.id.to_s + @day)
    end
  end
  
end