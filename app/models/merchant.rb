class Merchant < ApplicationRecord
  has_many :merchant_invoices
  #has_many :invoices, through: :merchant_invoices
  #has_many :items, through: :invoices
  #has_many :transactions, through: :invoices
  #has_many :customers, through: :invoices
  #has_many :invoice_items, through: :invoices

  validates_presence_of :name
end
