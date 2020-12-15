FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  
    trait :with_items do
      after :create do |merchant|
        create_list(:item, 4, merchant: merchant)
      end
    end
  end
end
