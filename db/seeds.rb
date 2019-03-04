ActiveRecord::Base.transaction do

  #
  # Admin employee
  #
  admin = Employee.create!(
    first_name: 'Peter',
    last_name: 'Parker',
    password: '234234234',
    email: 'admin@example.com',
    role: 'admin'
  )

  #
  # Staff employee
  #
  employee = Employee.create!(
    first_name: 'John',
    last_name: 'Doe',
    password: '123123123',
    email: 'johndoe@example.com',
    role: 'staff'
  )

  #
  # Assistances:
  #   3 consecutive days with 4 assistances each one for the staff employee.
  # Worked hours:
  #   Worked hours are calculated for every assistance of kind 'out'.
  # Anomalies:
  #   Register anomalies for each day.
  #

  base_date = DateTime.now
  day_hours = [[8, 13, 15, 18], [8.5, 14, 15, 19], [7.5, 12.5, 13.5, 19]]
  
  day_hours.each_with_index do |hours, index|
    date = base_date + index.days
    # Create assistances
    hours.each_with_index do |hour, hour_index|
      Assistance.create!(
        employee: employee,
        happening_at: date.beginning_of_day + hour.hours,
        kind: hour_index.even? ? 'in' : 'out'
      )
    end

    # Register anomalities
    RegisterAnomalies.for(employee: employee, day: date)
  end

  # puts employee.assistances.count
  # puts employee.work_days.count
  # puts employee.anomalies.count
  # puts 'Work days: day'
  # puts employee.work_days.map(&:day)
  # puts 'Work days: total_hours'
  # puts employee.work_days.map(&:total_hours)
  # puts 'Anomalies'
  # puts employee.anomalies.map(&:day)
end