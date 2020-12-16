class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_one(search_key, search_value)
    if search_key == 'name' || search_key == 'description'
      Item.find_by("LOWER(#{search_key}) LIKE ?", "%#{search_value.downcase}%")
    elsif search_key == 'unit_price'
      Item.find_by("#{search_key} = #{search_value.to_f}")
    # elsif search_key == 'created_at' || search_key == 'updated_at'
    #   require 'pry'; binding.pry
    #   Item.find_by("#{search_key} = '%#{search_value.to_date}%'")
    end
  end
end
