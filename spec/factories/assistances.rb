FactoryBot.define do
  factory :assistance do
    happening_at { DateTime.now.beginning_of_day }
    kind { 'in' }
    employee

    trait :exit do
      kind { 'out' }
    end

    trait :entry do
      kind { 'in' }
    end
    
    # TODO: Use hours set in schedule.yml

    trait :early do
      happening_at { DateTime.now.change(hour: 7)  } 
    end
    
    trait :midday do
      happening_at { DateTime.now.change(hour: 12) } 
    end

    trait :midafternoon do
      happening_at { DateTime.now.change(hour: 15)   } 
    end

    trait :night do
      happening_at { DateTime.now.change(hour: 19)   } 
    end

    factory :good_entry_assistance, traits: [:early, :entry]
    factory :bad_entry_assistance, traits: [:midday, :entry]
    factory :good_exit_assistance, traits: [:night, :exit]
    factory :bad_exit_assistance, traits: [:midafternoon, :exit]
  end
end