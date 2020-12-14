require 'rails_helper'

describe 'Merchant' do
  it 'sends list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_sucessful
  end
end