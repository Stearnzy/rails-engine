class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_one(search_key, search_value)
    Item.find_by("LOWER(#{search_key}) LIKE ?", "%#{search_value.downcase}%")
  end
end
