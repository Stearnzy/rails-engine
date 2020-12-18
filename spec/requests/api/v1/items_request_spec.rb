require 'rails_helper'

describe 'Item' do
  it 'returns index of items' do
    create_list(:item, 10, merchant: create(:merchant))

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(10)

    items[:data].each do |item|
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  it 'finds an item by id' do
    create(:item, name: 'Sunglasses', merchant: create(:merchant))
    glasses = Item.last

    get "/api/v1/items/#{glasses.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a String

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a String

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a Float
  end

  it 'creates an item' do
    merch_id = create(:merchant).id

    item_params = { name: 'Top Hat', description: 'Goes on your head.',
                    unit_price: 42.50, merchant_id: merch_id }
    headers = { 'CONTENT-TYPE' => 'application/json' }

    post '/api/v1/items', headers: headers, params: JSON.generate(item_params)
    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'updates an existing item' do
    original_item = create(:item)
    item_params = { unit_price: 75.50 }
    headers = { 'CONTENT-TYPE' => 'application/json' }

    patch "/api/v1/items/#{original_item.id}", headers: headers, params: JSON.generate(item_params)
    updated_item = Item.find(original_item.id)

    expect(response).to be_successful

    expect(original_item.name).to eq(updated_item.name)
    expect(original_item.description).to eq(updated_item.description)
    expect(original_item.merchant_id).to eq(updated_item.merchant_id)

    expect(original_item.unit_price).to_not eq(updated_item.unit_price)
    expect(updated_item.unit_price).to eq(75.50)
  end

  it 'deletes an existing item' do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
    expect(response.status).to eq(204)
  end

  # EDGE CASE
  it 'cannot be created with an item price of 0 or less' do
    merch_id = create(:merchant).id

    item_params = { name: 'Top Hat', description: 'Goes on your head.',
                    unit_price: 40.00, merchant_id: merch_id }
    headers = { 'CONTENT-TYPE' => 'application/json' }

    expect(Item.count).to eq(0)
    post '/api/v1/items', headers: headers, params: JSON.generate(item_params)

    expect(response).to be_successful
    expect(Item.count).to eq(1)

    item_params = { name: 'Top Hat', description: 'Goes on your head.',
                    unit_price: -1.00, merchant_id: merch_id }
    headers = { 'CONTENT-TYPE' => 'application/json' }

    post '/api/v1/items', headers: headers, params: JSON.generate(item_params)

    expect(response).to be_successful
    expect(Item.count).to eq(1)
  end
end
