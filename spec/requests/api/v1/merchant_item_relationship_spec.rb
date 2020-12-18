require 'rails_helper'

describe 'Merchants' do
  it 'can return all items a merchant provides' do
    merchant_1 = create(:merchant, :with_items)
    merchant_2 = create(:merchant, :with_items, items: 6)

    get "/api/v1/merchants/#{merchant_2.id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(6)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item).to have_key(:type)
      expect(item).to have_key(:attributes)

      expect(item[:type]).to eq('item')

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a String

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a Float

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a String

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an Integer
      expect(item[:attributes][:merchant_id]).to eq(merchant_2.id)
    end
  end
end

describe 'Items' do
  it 'can return the merchant an item belongs to' do
    created_merchant = create(:merchant)
    item = create(:item, merchant: created_merchant)

    get "/api/v1/items/#{item.id}/merchants"

    expect(response).to be_successful
    merchant_result = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_result[:data]).to have_key(:id)
    expect(merchant_result[:data]).to have_key(:type)
    expect(merchant_result[:data]).to have_key(:attributes)

    expect(merchant_result[:data][:type]).to eq('merchant')

    expect(merchant_result[:data][:attributes]).to have_key(:name)
    expect(merchant_result[:data][:attributes][:name]).to be_a String
    expect(merchant_result[:data][:attributes][:name]).to_not be_empty

    expect(merchant_result[:data][:id]).to eq(created_merchant.id.to_s)
  end
end
