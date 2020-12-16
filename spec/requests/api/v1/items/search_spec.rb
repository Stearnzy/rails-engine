require 'rails_helper'

describe 'Item search' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Cheesemeister')
    @item_1 = Item.create!(name: 'Stinky Blue Cheese', description: 'Smells like feet', unit_price: 15.50, merchant_id: @merchant_1.id, created_at: '2015-04-13', updated_at: '2020-11-15')
    @item_2 = Item.create!(name: 'Simply Swiss Cheese', description: 'Holy moly', unit_price: 10.00, merchant_id: @merchant_1.id, created_at: '2014-12-25', updated_at: '2020-09-11')
    @item_3 = Item.create!(name: 'Cowboy Cheddar Cheese', description: 'Sharp as a tack', unit_price: 8.75, merchant_id: @merchant_1.id, created_at: '2012-02-15', updated_at: '2020-10-31')
    @item_4 = Item.create!(name: 'Goat Gouda Cheese', description: 'Baaaaah', unit_price: 15.50, merchant_id: @merchant_1.id, created_at: '2014-03-13', updated_at: '2020-12-01')
  end

  describe 'Single Search' do
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
      expect(result[:data][:type]).to be_a String
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

    it 'I get only one result' do
      get '/api/v1/items/find?name=a'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
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

    it 'searches by description' do
      get '/api/v1/items/find?description=ShaR'

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

    it 'searches by unit_price' do
      get '/api/v1/items/find?unit_price=15.50'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a Hash

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data]).to be_a Hash

      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes][:name]).to be_a String
      expect(result[:data][:attributes][:name]).to eq(@item_1.name)

      expect(result[:data][1]).to be_nil
    end

    xit 'searches by date' do
    end
  end

  describe 'Multiple search' do
    it 'when I search for an item name, I get multiple results' do
      get '/api/v1/items/find_all?name=Cheese'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result).to have_key(:data)
      expect(result[:data]).to be_an Array

      expect(result[:data].count).to eq(4)

      expect(result[:data][0]).to have_key(:id)
      expect(result[:data][0][:id]).to be_a String
      expect(result[:data][0][:id]).to eq(@item_1.id.to_s)

      expect(result[:data][0]).to have_key(:type)
      expect(result[:data][0][:type]).to eq('item')

      expect(result[:data][0]).to have_key(:attributes)
      expect(result[:data][0]).to be_a Hash

      expect(result[:data][0][:attributes]).to have_key(:name)
      expect(result[:data][0][:attributes][:name]).to be_a String
      expect(result[:data][0][:attributes][:name]).to eq(@item_1.name)

      expect(result[:data][0][:attributes]).to have_key(:description)
      expect(result[:data][0][:attributes][:description]).to be_a String
      expect(result[:data][0][:attributes][:description]).to eq(@item_1.description)

      expect(result[:data][0][:attributes]).to have_key(:unit_price)
      expect(result[:data][0][:attributes][:unit_price]).to be_a Float
      expect(result[:data][0][:attributes][:unit_price]).to eq(@item_1.unit_price)

      expect(result[:data][0][:attributes]).to have_key(:merchant_id)
      expect(result[:data][0][:attributes][:merchant_id]).to be_a Integer
      expect(result[:data][0][:attributes][:merchant_id]).to eq(@item_1.merchant_id)
    end

    it 'I can return more than one result' do
      get '/api/v1/items/find_all?name=Cheese'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data]).to be_an Array

      expect(result[:data].count).to eq(4)
      expect(result[:data][0][:attributes][:name]).to eq(@item_1.name)
      expect(result[:data][1][:attributes][:name]).to eq(@item_2.name)
      expect(result[:data][2][:attributes][:name]).to eq(@item_3.name)
      expect(result[:data][3][:attributes][:name]).to eq(@item_4.name)
    end

    it 'search can be case insensitive' do
      get '/api/v1/items/find_all?name=ChEEse'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(4)
      expect(result[:data][0][:attributes][:name]).to eq(@item_1.name)
      expect(result[:data][1][:attributes][:name]).to eq(@item_2.name)
      expect(result[:data][2][:attributes][:name]).to eq(@item_3.name)
      expect(result[:data][3][:attributes][:name]).to eq(@item_4.name)
    end

    it 'search can be partial' do
      get '/api/v1/items/find_all?name=b'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)
      expect(result[:data][0][:attributes][:name]).to eq(@item_1.name)
      expect(result[:data][1][:attributes][:name]).to eq(@item_3.name)
    end

    it 'searches by description' do
      get '/api/v1/items/find_all?description=h'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(3)
      expect(result[:data][0][:attributes][:name]).to eq(@item_2.name)
      expect(result[:data][1][:attributes][:name]).to eq(@item_3.name)
      expect(result[:data][2][:attributes][:name]).to eq(@item_4.name)
    end

    it 'searches by unit_price' do
      get '/api/v1/items/find_all?unit_price=15.50'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result[:data].count).to eq(2)
      expect(result[:data][0][:attributes][:name]).to eq(@item_1.name)
      expect(result[:data][1][:attributes][:name]).to eq(@item_4.name)
    end

    xit 'searches by date' do
    end
  end
end
