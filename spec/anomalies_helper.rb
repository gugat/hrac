
  #
  #  Assumes declared: 
  # `employee`: The employee related to the anomalies.
  # `base_date`: Date for the first record of anomalies.
  #

  def generate_anomalies_with_one_day_difference
    (0..2).each do |extra_day|
      create(:anomaly, 
        day: base_date + extra_day.days,
        employee: employee) 
    end
  end