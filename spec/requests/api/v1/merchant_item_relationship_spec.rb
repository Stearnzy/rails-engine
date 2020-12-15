require 'rails_helper'

describe 'Merchants' do
  it 'can return all items a merchant provides' do
    merchant_1 = create(:merchant, :with_items)
    merchant_2 = create(:merchant, :with_items, items: 6)

    get "/api/v1/merchants/#{merchant_2.id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(6)
  end
end