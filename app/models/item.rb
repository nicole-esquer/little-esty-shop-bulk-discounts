class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
 
  validates_presence_of :merchant_id, :name, :description, :unit_price

  def self.enabled
    joins(:invoice_items).where(invoice_items: { status: :pending }).distinct(:item_id).order(id: :asc)
  end
end
