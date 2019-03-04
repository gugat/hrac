FactoryBot.define do
  factory :anomaly do
    absence { false }
    worked_too_short { false }
    incomplete_assistances { false }
    arrived_late { true }
    finished_too_early { true }
    day { DateTime.now.beginning_of_day }
    employee
  end
end