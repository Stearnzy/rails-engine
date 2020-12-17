FactoryBot.define do
  factory :invoice do
    status { "shipped" }
    created_at { '2020-05-01' }
    customer
    merchant { nil }
  end
end
