class Merchant < ApplicationRecord
  has_many :items
  has_many :merchant_invoices
  has_many :invoices, through: :merchant_invoices
  has_many :customers, through: :invoices
  
  validates_presence_of :name
end
