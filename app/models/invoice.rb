class Invoice < ApplicationRecord
  belongs_to :customer
  # has_many :merchant_invoices
  
  has_many :merchants
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: { cancelled: 0, "in progress" => 1, completed: 2 }

  validates_presence_of :customer_id, :status

  enum status: { cancelled: 0, "in progress" => 1, completed: 2 }
end
