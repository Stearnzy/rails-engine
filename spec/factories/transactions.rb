FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Date.between(from: Date.today, to: '2025-10-31') }
    result { "failed" }
    invoice
  end
end
