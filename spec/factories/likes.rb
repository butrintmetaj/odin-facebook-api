FactoryBot.define do
  factory :like do
    association :user, factory: :user
    association :likeable, factory: :post

    trait :comment do
      association :likeable, factory: :comment
    end
  end
end
