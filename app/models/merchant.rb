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
      Merchant.find_by("DATE(#{search_key}) = ?", search_value.to_date.to_s)
    end
  end

  def self.find_all(search_key, search_value)
    if search_key == 'name'
      Merchant.where("LOWER(#{search_key}) LIKE ?", "%#{search_value.downcase}%")
    elsif search_key == 'created_at' || search_key == 'updated_at'
      Merchant.where("DATE(#{search_key}) = ?", search_value.to_date.to_s)
    end
  end

  def self.most_revenue(limit)
    select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
      .joins(invoices: %i[invoice_items transactions])
      .where(transactions: { result: 'success' })
      .where(invoices: { status: 'shipped' })
      .group(:id)
      .order('revenue DESC')
      .limit(limit)
  end

  def self.most_items_sold(limit)
    select('merchants.*, SUM(invoice_items.quantity) AS items_sold')
      .joins(invoices: %i[invoice_items transactions])
      .where(transactions: { result: 'success' })
      .where(invoices: { status: 'shipped' })
      .group(:id)
      .order('items_sold DESC')
      .limit(limit)
  end

  def self.total_revenue(id)
    joins(invoices: %i[invoice_items transactions])
      .where(id: id)
      .where(transactions: { result: 'success' })
      .where(invoices: { status: 'shipped' })
      .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
