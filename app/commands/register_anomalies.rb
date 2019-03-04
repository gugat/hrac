class RegisterAnomalies < PowerTypes::Command.new(:employee, :day)

  def perform
    service = EmployeeAnomaliesService.new(@employee, @day)
    Anomaly.create!(
      absence: service.absence?,
      worked_too_short: service.worked_too_short?,
      arrived_late: service.arrived_late?,
      finished_too_early: service.finished_too_early?,
      incomplete_assistances: service.incomplete_assistances?,
      day: @day.midnight,
      employee: @employee
    )
  end
end
