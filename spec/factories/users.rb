FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    gender { Faker::Gender.binary_type.downcase }
    birthday { Faker::Date.birthday }
  end
end
