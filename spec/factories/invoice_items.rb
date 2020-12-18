FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Commerce.price }
  end
end
