require 'rails_helper'

describe 'Merchant search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'The Bowling Lane', created_at: '2020-12-13', updated_at: '2020-12-15')
    @merchant_2 = Merchant.create!(name: 'Goldfish Central', created_at: '2020-11-11', updated_at: '2020-12-01')
  end

  it 'when I search for a merchant, I get results' do
    get "/api/v1/merchants/find?name=The+Bowling+Lane"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

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
