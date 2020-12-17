FactoryBot.define do
  factory :invoice do
    status { "shipped" }
    customer
    merchant { nil }
  end
end
