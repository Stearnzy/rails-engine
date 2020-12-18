require 'rails_helper'

describe 'Most Revenue' do
  before(:each) do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @merch3 = create(:merchant)
    @merch4 = create(:merchant)
    @merch5 = create(:merchant)

    @inv1 = create(:invoice, merchant_id: @merch1.id, updated_at: '2020-02-01')
    create(:transaction, result: 'success', invoice_id: @inv1.id)
    create(:invoice_item, quantity: 1, unit_price: 20.00, invoice_id: @inv1.id, item_id: create(:item, unit_price: 20.00).id)

    @inv2 = create(:invoice, merchant_id: @merch2.id, updated_at: '2020-03-01')
    create(:transaction, result: 'success', invoice_id: @inv2.id)
    create(:invoice_item, quantity: 2, unit_price: 20.00, invoice_id: @inv2.id, item_id: create(:item, unit_price: 20.00).id)

    @inv3 = create(:invoice, merchant_id: @merch3.id, updated_at: '2020-04-01')
    create(:transaction, result: 'success', invoice_id: @inv3.id)
    create(:invoice_item, quantity: 3, unit_price: 20.00, invoice_id: @inv3.id, item_id: create(:item, unit_price: 20.00).id)

    @inv4 = create(:invoice, merchant_id: @merch4.id, updated_at: '2020-05-01')
    create(:transaction, result: 'success', invoice_id: @inv4.id)
    create(:invoice_item, quantity: 4, unit_price: 20.00, invoice_id: @inv4.id, item_id: create(:item, unit_price: 20.00).id)

    @inv5 = create(:invoice, merchant_id: @merch5.id, updated_at: '2020-06-01')
    create(:transaction, result: 'success', invoice_id: @inv5.id)
    create(:invoice_item, quantity: 5, unit_price: 20.00, invoice_id: @inv5.id, item_id: create(:item, unit_price: 20.00).id)

    @inv6 = create(:invoice, merchant_id: @merch1.id, updated_at: '2020-07-01')
    create(:transaction, result: 'failed', invoice_id: @inv6.id)
    create(:invoice_item, quantity: 10, unit_price: 20.00, invoice_id: @inv6.id, item_id: create(:item, unit_price: 20.00).id)

    @inv7 = create(:invoice, merchant_id: @merch2.id, status: 'packaged', updated_at: '2020-08-01')
    create(:transaction, result: 'success', invoice_id: @inv7.id)
    create(:invoice_item, quantity: 15, unit_price: 20.00, invoice_id: @inv7.id, item_id: create(:item, unit_price: 20.00).id)

    @inv8 = create(:invoice, merchant_id: @merch3.id, updated_at: '2020-09-01')
    create(:transaction, result: 'success', invoice_id: @inv8.id)
    create(:invoice_item, quantity: 20, unit_price: 20.00, invoice_id: @inv8.id, item_id: create(:item, unit_price: 20.00).id)

    @inv9 = create(:invoice, merchant_id: @merch2.id, updated_at: '2020-10-01')
    create(:transaction, result: 'success', invoice_id: @inv9.id)
    create(:invoice_item, quantity: 32, unit_price: 20.00, invoice_id: @inv9.id, item_id: create(:item, unit_price: 20.00).id)
  end

  it 'returns merchants with most revenue' do
    quantity = 4
    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(quantity)

    expect(merchants[:data][0][:id]).to eq(@merch2.id.to_s)
    expect(merchants[:data][1][:id]).to eq(@merch3.id.to_s)
    expect(merchants[:data][2][:id]).to eq(@merch5.id.to_s)
    expect(merchants[:data][3][:id]).to eq(@merch4.id.to_s)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq('merchant')
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:id].to_i).to_not eq(@merch1.id)
    end
  end

  it 'returns revenue for a single merchant' do
    id = @merch2.id
    get "/api/v1/merchants/#{id}/revenue"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data]).to have_key(:attributes)

    expect(merchant[:data][:id]).to eq(nil)

    expect(merchant[:data][:attributes]).to have_key(:revenue)
    expect(merchant[:data][:attributes][:revenue]).to be_a Float
    expect(merchant[:data][:attributes][:revenue]).to eq(680.0)
  end

  it 'returns the total revenue between dates' do
    starting = '2020-03-19'
    ending = '2020-09-16'

    expected_revenue = 640.0

    get "/api/v1/revenue?start=#{starting}&end=#{ending}"

    expect(response).to be_successful

    revenue_data = JSON.parse(response.body, symbolize_names: true)

    expect(revenue_data).to have_key(:data)
    expect(revenue_data[:data]).to have_key(:id)
    expect(revenue_data[:data][:id]).to be_nil

    expect(revenue_data[:data]).to have_key(:attributes)
    expect(revenue_data[:data][:attributes]).to be_a Hash
    expect(revenue_data[:data][:attributes]).to have_key(:revenue)
    expect(revenue_data[:data][:attributes][:revenue]).to be_a Float
    expect(revenue_data[:data][:attributes][:revenue]).to eq(expected_revenue)
  end

  it 'errors if ending date comes before starting date' do
    starting = '2020-09-16'
    ending = '2020-03-19'

    get "/api/v1/revenue?start=#{starting}&end=#{ending}"

    expect(response).to be_successful

    error = JSON.parse(response.body, symbolize_names: true)

    expect(error).to be_a Hash
    expect(error).to have_key(:error)
    expect(error[:error]).to be_a String
    expect(error[:error]).to eq('end date occurs before start date')
  end
end
