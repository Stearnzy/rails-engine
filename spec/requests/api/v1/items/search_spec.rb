require 'rails_helper'

describe 'Item search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Cheesemeister')
    @item_1 = Item.create!(name: 'Stinky Blue Cheese', description: 'Smells like feet', unit_price: 12.25, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: 'Simply Swiss Cheese', description: 'Holy moly', unit_price: 10.00, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: 'Cowboy Cheddar Cheese', description: 'Sharp as a tack', unit_price: 8.75, merchant_id: @merchant_1.id)
    @item_4 = Item.create!(name: 'Goat Gouda Cheese', description: 'Baaaaah', unit_price: 15.50, merchant_id: @merchant_1.id)
  end

  it 'when I search for a merchant, I get results' do
    get "/api/v1/merchants/find?name=Stinky+Blue+Cheese"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)
require 'pry'; binding.pry






    expect(result).to be_a Hash
    expect(result).to have_key(:data)
    expect(result[:data]).to be_a Hash
    
    expect(result[:data]).to have_key(:attributes)
    expect(result[:data]).to be_a Hash
    
    expect(result[:data][:attributes]).to have_key(:name)
    expect(result[:data][:attributes][:name]).to be_a String
    expect(result[:data][:attributes][:name]).to eq(@merchant_1.name)
  end

  xit 'I get only one result' do
    get "/api/v1/merchants/find?name=a"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    require 'pry'; binding.pry
  end

  it 'search can be case insensitive' do
    get "/api/v1/merchants/find?name=GoLdFIsH"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a Hash
    expect(result).to have_key(:data)
    expect(result[:data]).to be_a Hash
    
    expect(result[:data]).to have_key(:attributes)
    expect(result[:data]).to be_a Hash
    
    expect(result[:data][:attributes]).to have_key(:name)
    expect(result[:data][:attributes][:name]).to be_a String
    expect(result[:data][:attributes][:name]).to eq(@merchant_2.name)
  end

  it 'search can be partial' do
    get "/api/v1/merchants/find?name=ldfi"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to be_a Hash
    expect(result).to have_key(:data)
    expect(result[:data]).to be_a Hash
    
    expect(result[:data]).to have_key(:attributes)
    expect(result[:data]).to be_a Hash
    
    expect(result[:data][:attributes]).to have_key(:name)
    expect(result[:data][:attributes][:name]).to be_a String
    expect(result[:data][:attributes][:name]).to eq(@merchant_2.name)
  end

  xit 'searches by date' do

  end

end