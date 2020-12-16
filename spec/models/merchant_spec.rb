require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'model methods' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: 'The Rusty Bucket', created_at: '2020-12-13', updated_at: '2020-12-15')
      @merchant_2 = Merchant.create!(name: 'The Clean Spoon', created_at: '2020-11-11', updated_at: '2020-12-01')
      @merchant_3 = Merchant.create!(name: 'Cheesemeister', created_at: '2020-11-11', updated_at: '2020-12-15')
    end

    describe '#find_one' do
      it 'finds based on name' do
        expect(Merchant.find_one('name', 'The Rusty Bucket')).to eq(@merchant_1)
      end

      it 'finds based on partial search' do
        expect(Merchant.find_one('name', 'Rus')).to eq(@merchant_1)
      end

      it 'finds case insensitive' do
        expect(Merchant.find_one('name', 'ClEAn')).to eq(@merchant_2)
      end

      it 'finds one' do
        result = [Merchant.find_one('name', 'The')]
        expect(result.count).to eq(1)
      end

      it 'finds based on created_at' do
        expect(Merchant.find_one('created_at', '2020-12-13')).to eq(@merchant_1)
      end

      it 'finds based on updated_at' do
        expect(Merchant.find_one('updated_at', '2020-12-01')).to eq(@merchant_2)
      end
    end

    describe '#find_all' do
      it 'finds based on name' do
        expect(Merchant.find_all('name', 'The').count).to eq(2)
        expect(Merchant.find_all('name', 'The')).to eq([@merchant_1, @merchant_2])
      end

      it 'finds based on partial search' do
        expect(Merchant.find_all('name', 'Th').count).to eq(2)
        expect(Merchant.find_all('name', 'Th')).to eq([@merchant_1, @merchant_2])
      end

      it 'finds case insensitive' do
        expect(Merchant.find_all('name', 'tHE').count).to eq(2)
        expect(Merchant.find_all('name', 'tHE')).to eq([@merchant_1, @merchant_2])
      end

      it 'finds based on created_at' do
        expect(Merchant.find_all('created_at', '2020-11-11').count).to eq(2)
        expect(Merchant.find_all('created_at', '2020-11-11')).to eq([@merchant_2, @merchant_3])
      end

      it 'finds based on updated_at' do
        expect(Merchant.find_all('updated_at', '2020-12-15').count).to eq(2)
        expect(Merchant.find_all('updated_at', '2020-12-15')).to eq([@merchant_1, @merchant_3])
      end
    end
  end
end
