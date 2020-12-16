require 'rails_helper'

describe 'Merchant search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'The Bowling Lane', created_at: '2015-12-13', updated_at: '2020-12-15')
    @merchant_2 = Merchant.create!(name: 'Goldfish Central', created_at: '2013-11-11', updated_at: '2020-12-15')
    @merchant_3 = Merchant.create!(name: 'The Rusty Bowl', created_at: '2013-11-11', updated_at: '2019-10-01')
  end

  describe 'find_one' do
    it 'when I search for a merchant, I get results' do
      get '/api/v1/merchants/find?name=The+Bowling+Lane'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a Hash

      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to be_a String
      expect(result[:data][:id]).to eq(@merchant_1.id.to_s)

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to be_a String
      expect(result[:data][:type]).to eq('merchant')

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data]).to be_a Hash

      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes][:name]).to be_a String
      expect(result[:data][:attributes][:name]).to eq(@merchant_1.name)
    end

    xit 'I get only one result' do
      get '/api/v1/merchants/find?name=a'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      require 'pry'; binding.pry
    end

    it 'search can be case insensitive' do
      get '/api/v1/merchants/find?name=GoLdFIsH'

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
      get '/api/v1/merchants/find?name=ldfi'

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

  describe 'Multiple search' do
    it 'when I search for an item name, I get multiple results' do
      get '/api/v1/merchants/find_all?name=Bowl'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)
      expect(result[:data]).to be_an Array

      expect(result[:data].count).to eq(2)

      expect(result[:data][0]).to have_key(:id)
      expect(result[:data][0][:id]).to be_a String
      expect(result[:data][0][:id]).to eq(@merchant_1.id.to_s)

      expect(result[:data][0]).to have_key(:type)
      expect(result[:data][0][:type]).to eq('merchant')

      expect(result[:data][0]).to have_key(:attributes)
      expect(result[:data][0]).to be_a Hash

      expect(result[:data][0][:attributes]).to have_key(:name)
      expect(result[:data][0][:attributes][:name]).to be_a String
      expect(result[:data][0][:attributes][:name]).to eq(@merchant_1.name)
    end

    it 'I can return more than one result' do
      get '/api/v1/merchants/find_all?name=Bowl'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)
    end

    it 'search can be case insensitive' do
      get '/api/v1/merchants/find_all?name=boWL'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)
      expect(result[:data][0][:attributes][:name]).to eq(@merchant_1.name)
      expect(result[:data][1][:attributes][:name]).to eq(@merchant_3.name)
    end

    it 'search can be partial' do
      get '/api/v1/merchants/find_all?name=b'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)
      expect(result[:data][0][:attributes][:name]).to eq(@merchant_1.name)
      expect(result[:data][1][:attributes][:name]).to eq(@merchant_3.name)
    end

    xit 'searches by date' do
    end
  end
end
