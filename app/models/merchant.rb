class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.find_one(search_key, search_value)
    Merchant.find_by("LOWER(#{search_key}) LIKE ?", "%#{search_value.downcase}%")
  end
end
