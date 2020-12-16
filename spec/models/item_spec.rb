require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'model methods' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'Cheesemeister')
      @item_1 = Item.create!(name: 'Stinky Blue Cheese', description: 'Smells like feet', unit_price: 12.25, merchant_id: @merchant_1.id, created_at: '2015-04-13', updated_at: '2020-11-15')
      @item_2 = Item.create!(name: 'Simply Swiss Cheese', description: 'Holy moly', unit_price: 10.00, merchant_id: @merchant_1.id, created_at: '2014-12-25', updated_at: '2020-09-11')
      end

    describe '#find_one' do
      it 'finds based on name' do
        expect(Item.find_one('name', 'Stinky Blue Cheese')).to eq(@item_1)
      end

      it 'finds based on partial search' do
        expect(Item.find_one('name', 'tin')).to eq(@item_1)
      end

      it 'finds case insensitive' do
        expect(Item.find_one('name', 'STinK')).to eq(@item_1)
      end

      it 'finds one' do
        result = [Item.find_one('name', 'The')]
        expect(result.count).to eq(1)
      end

      it 'finds based on description' do
        expect(Item.find_one('description', 'hOL')).to eq(@item_2)
      end

      it 'finds based on unit_price' do
        expect(Item.find_one('unit_price', 12.25)).to eq(@item_1)
      end

      xit 'finds based on created_at' do

      end

      xit 'finds based on updated_at' do

      end
    end
  end
end
