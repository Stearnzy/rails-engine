FactoryBot.define do
  factory :transaction do
    credit_card_number { "" }
    credit_card_expiration_date { "" }
    result { "" }
    invoice { nil }
  end
end
