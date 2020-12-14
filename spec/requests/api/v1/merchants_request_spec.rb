require 'rails_helper'

describe 'Merchant' do
  it 'sends list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(5)

    merchants.each do |merchant|
      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end
  end

  it 'returns a merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to eq(id)

    expect(merchant).to have_key(:name)
    expect(merchant[:name]).to be_a(String)
  end

  it 'creates a merchant' do
    merchant_params = { name: 'Krusty Krab' }

    headers = { 'CONTENT-TYPE' => 'application/json' }

    post '/api/v1/merchants', headers: headers, params: JSON.generate(merchant: merchant_params)
    created_merchant = Merchant.last

    expect(response).to be_successful
    expect(created_merchant.name).to eq(merchant_params[:name])
  end

  it 'updates existing merchant' do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: 'Burger King' }
    headers = { 'CONTENT-TYPE' => 'application/json'}

    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(merchant: merchant_params)
    merchant = Merchant.find(id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq('Burger King')
  end

  it 'deletes a merchant' do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
