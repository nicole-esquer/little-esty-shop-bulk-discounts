class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices, source: :invoice_items
  has_many :merchants, through: :items, source: :invoice_items

  validates_presence_of :first_name, :last_name

end
