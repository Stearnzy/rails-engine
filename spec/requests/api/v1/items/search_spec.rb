require 'rails_helper'

describe 'Item search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Cheesemeister')
    @item_1 = Item.create!(name: 'Stinky Blue Cheese', description: 'Smells like feet', unit_price: 12.25, merchant_id: @merchant_1.id, created_at: '2015-04-13', updated_at: '2020-11-15')
    @item_2 = Item.create!(name: 'Simply Swiss Cheese', description: 'Holy moly', unit_price: 10.00, merchant_id: @merchant_1.id, created_at: '2014-12-25', updated_at: '2020-09-11')
    @item_3 = Item.create!(name: 'Cowboy Cheddar Cheese', description: 'Sharp as a tack', unit_price: 8.75, merchant_id: @merchant_1.id, created_at: '2012-02-15', updated_at: '2020-10-31')
    @item_4 = Item.create!(name: 'Goat Gouda Cheese', description: 'Baaaaah', unit_price: 15.50, merchant_id: @merchant_1.id, created_at: '2014-03-13', updated_at: '2020-12-01')
  end

  it 'when I search for an item name, I get results' do
    get '/api/v1/items/find?name=Stinky+Blue+Cheese'

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a Hash
    expect(result).to have_key(:data)
    expect(result[:data]).to be_a Hash

    expect(result[:data]).to have_key(:id)
    expect(result[:data][:id]).to be_a String
    expect(result[:data][:id]).to eq(@item_1.id.to_s)

    expect(result[:data]).to have_key(:type)
    expect(result[:data][:type]).to eq('item')

    expect(result[:data]).to have_key(:attributes)
    expect(result[:data]).to be_a Hash

    expect(result[:data][:attributes]).to have_key(:name)
    expect(result[:data][:attributes][:name]).to be_a String
    expect(result[:data][:attributes][:name]).to eq(@item_1.name)

    expect(result[:data][:attributes]).to have_key(:description)
    expect(result[:data][:attributes][:description]).to be_a String
    expect(result[:data][:attributes][:description]).to eq(@item_1.description)

    expect(result[:data][:attributes]).to have_key(:unit_price)
    expect(result[:data][:attributes][:unit_price]).to be_a Float
    expect(result[:data][:attributes][:unit_price]).to eq(@item_1.unit_price)

    expect(result[:data][:attributes]).to have_key(:merchant_id)
    expect(result[:data][:attributes][:merchant_id]).to be_a Integer
    expect(result[:data][:attributes][:merchant_id]).to eq(@item_1.merchant_id)
  end

  xit 'I get only one result' do
    get '/api/v1/items/find?name=a'

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    require 'pry'; binding.pry
  end

  it 'search can be case insensitive' do
    get '/api/v1/items/find?name=COWboy'

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a Hash
    expect(result).to have_key(:data)
    expect(result[:data]).to be_a Hash

    expect(result[:data]).to have_key(:attributes)
    expect(result[:data]).to be_a Hash

    expect(result[:data][:attributes]).to have_key(:name)
    expect(result[:data][:attributes][:name]).to be_a String
    expect(result[:data][:attributes][:name]).to eq(@item_3.name)
  end

  it 'search can be partial' do
    get '/api/v1/items/find?name=ou'

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a Hash
    expect(result).to have_key(:data)
    expect(result[:data]).to be_a Hash

    expect(result[:data]).to have_key(:attributes)
    expect(result[:data]).to be_a Hash

    expect(result[:data][:attributes]).to have_key(:name)
    expect(result[:data][:attributes][:name]).to be_a String
    expect(result[:data][:attributes][:name]).to eq(@item_4.name)
  end

  xit 'searches by description' do
  end

  xit 'searches by unit_price' do
  end

  xit 'searches by date' do
  end
end
