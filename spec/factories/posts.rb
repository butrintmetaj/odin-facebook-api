FactoryBot.define do
  factory :post do
    body { Faker::Lorem.paragraph }
    association :user, factory: :user
  end
end
