FactoryBot.define do
  factory :work_day do
    total_hours { 10 }
    day { DateTime.now.beginning_of_day }
    employee

    trait :few_hours do
      total_hours { 7 }
    end
    
    trait :long_hours do
      total_hours { 9 }
    end

  end
end