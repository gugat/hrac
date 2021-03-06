FactoryBot.define do
  factory :employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'mypassword' }
    uid { Faker::Internet.email }

    trait :admin do
      role { 'admin' }
    end
  end
end