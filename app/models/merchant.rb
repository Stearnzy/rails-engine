class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.find_one(search_key, search_value)
    if search_key == 'name'
      Merchant.find_by("LOWER(#{search_key}) LIKE ?", "%#{search_value.downcase}%")
    elsif search_key == 'created_at' || search_key == 'updated_at'
      Merchant.find_by("#{search_key} = '%#{search_value.to_date}%'")
    end
  end

  def self.find_all(search_key, search_value)
    if search_key == 'name'
      Merchant.where("LOWER(#{search_key}) LIKE ?", "%#{search_value.downcase}%")
    elsif search_key == 'created_at' || search_key == 'updated_at'
      Merchant.where("#{search_key} = '%#{search_value.to_date}%'")
    end
  end
end
