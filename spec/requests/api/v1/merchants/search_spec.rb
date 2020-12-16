require 'rails_helper'

describe 'Merchant search' do
  it 'when I search for a merchant, I get results' do
    merchant_1 = create(:merchant, name: 'The Bowling Lane')
    merchant_2 = create(:merchant, name: 'Goldfish Central')

    get "/api/v1/merchants/find?name=The+Bowling+Lane"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data][:id]).to eq(merchant_1.id.to_s)
  end  
end
