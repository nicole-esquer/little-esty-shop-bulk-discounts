class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
 
  validates_presence_of :merchant_id, :name, :description, :unit_price

  def enabled
    invoice_items.where(status: :pending)
  end
end
