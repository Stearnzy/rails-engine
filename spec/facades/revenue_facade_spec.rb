require 'rails_helper'

describe 'Revenue Facade' do
  it '#total_revenue_over_time' do
    @merch1 = create(:merchant)
    @merch2 = create(:merchant)
    @merch3 = create(:merchant)

    @inv1 = create(:invoice, merchant_id: @merch1.id, updated_at: '2020-02-01')
    create(:transaction, result: 'success', invoice_id: @inv1.id)
    create(:invoice_item, quantity: 1, unit_price: 20.00, invoice_id: @inv1.id, item_id: create(:item, unit_price: 20.00).id)

    @inv2 = create(:invoice, merchant_id: @merch2.id, updated_at: '2020-03-01')
    create(:transaction, result: 'success', invoice_id: @inv2.id)
    create(:invoice_item, quantity: 2, unit_price: 20.00, invoice_id: @inv2.id, item_id: create(:item, unit_price: 20.00).id)

    @inv3 = create(:invoice, merchant_id: @merch3.id, updated_at: '2020-04-01')
    create(:transaction, result: 'success', invoice_id: @inv3.id)
    create(:invoice_item, quantity: 3, unit_price: 20.00, invoice_id: @inv3.id, item_id: create(:item, unit_price: 20.00).id)

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

    start_date = '2020-07-01'
    end_date = '2020-10-01'
    expected_revenue = 1040

    expect(RevenueFacade.total_revenue_over_time(start_date, end_date)).to eq(expected_revenue)

  end
end