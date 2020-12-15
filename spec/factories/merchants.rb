FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  
    trait :with_items do
      transient do
        items { 3 }
      end

      after :create do |merchant, evaluator|
        create_list(:item, evaluator.items, merchant: merchant)
      end
    end
  end
end
