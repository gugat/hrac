FactoryBot.define do
  factory :assistance do
    happening_at { Faker::Time.between(0.days.ago, Date.today, :morning) }
    kind { 'in' }
    employee
  end
end