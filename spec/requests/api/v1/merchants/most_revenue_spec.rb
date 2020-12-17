require 'rails_helper'

describe 'Most Revenue' do
  before(:each) do
    # merchant_1 = create(:merchant)
    # merchant_2 = create(:merchant)
    # merchant_3 = create(:merchant)
    # merchant_4 = create(:merchant)
    # merchant_5 = create(:merchant)

    # invoice_1 = create(:invoice, merchant_id: merchant_1.id)
    # create(:transaction, result: "success", invoice_id: invoice_1.id)
    # create(:invoice_item, quantity: 20, unit_price: 100.00, invoice_id: invoice_1.id, item_id: create(:item, unit_price: 100.00).id)
    
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @merch3 = create(:merchant)
    @merch4 = create(:merchant)
    @merch5 = create(:merchant)

    @inv1 = create(:invoice, merchant_id: @merch1.id)
    create(:transaction, result: "success", invoice_id: @inv1.id)
    create(:invoice_item, quantity: 1, unit_price: 20.00, invoice_id: @inv1.id, item_id: create(:item, unit_price: 20.00).id)

    @inv2 = create(:invoice, merchant_id: @merch2.id)
    create(:transaction, result: "success", invoice_id: @inv2.id)
    create(:invoice_item, quantity: 2, unit_price: 20.00, invoice_id: @inv2.id, item_id: create(:item, unit_price: 20.00).id)

    @inv3 = create(:invoice, merchant_id: @merch3.id)
    create(:transaction, result: "success", invoice_id: @inv3.id)
    create(:invoice_item, quantity: 3, unit_price: 20.00, invoice_id: @inv3.id, item_id: create(:item, unit_price: 20.00).id)

    @inv4 = create(:invoice, merchant_id: @merch4.id)
    create(:transaction, result: "success", invoice_id: @inv4.id)
    create(:invoice_item, quantity: 4, unit_price: 20.00, invoice_id: @inv4.id, item_id: create(:item, unit_price: 20.00).id)

    @inv5 = create(:invoice, merchant_id: @merch5.id)
    create(:transaction, result: "success", invoice_id: @inv5.id)
    create(:invoice_item, quantity: 5, unit_price: 20.00, invoice_id: @inv5.id, item_id: create(:item, unit_price: 20.00).id)

    @inv6 = create(:invoice, merchant_id: @merch1.id)
    create(:transaction, result: "failed", invoice_id: @inv6.id)
    create(:invoice_item, quantity: 10, unit_price: 20.00, invoice_id: @inv6.id, item_id: create(:item, unit_price: 20.00).id)

    @inv7 = create(:invoice, merchant_id: @merch2.id, status: "packaged")
    create(:transaction, result: "success", invoice_id: @inv7.id)
    create(:invoice_item, quantity: 15, unit_price: 20.00, invoice_id: @inv7.id, item_id: create(:item, unit_price: 20.00).id)
  end

  it 'returns merchants with most revenue' do
    
    require 'pry'; binding.pry
  end
end