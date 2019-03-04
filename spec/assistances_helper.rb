  #
  #  Assumes declared: 
  # `employee`: The employee related to the assistances.
  # `assistance_day`: Day for the assistances.
  #

  def generate_assistances_for_one_day
    [8, 13, 15, 18].each_with_index do |hour, index|
      create(:assistance, 
             happening_at: assistance_day.change(hour: hour),
             employee: employee,
             kind: index.even? ? 'in' : 'out')
    end
  end

  #
  #  Assumes declared: 
  # `employee`: The employee related to the assistances.
  # `base_date`: Date for the first assistance.
  #

  def generate_assistances_with_one_day_difference
    (0..2).each do |extra_day|
      create(:good_entry_assistance, 
        happening_at: base_date + extra_day.days,
        employee: employee) 
    end
  end

  #
  #
  #
  #
