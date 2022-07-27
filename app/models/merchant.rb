class Merchant < ApplicationRecord
  has_many :items
  has_many :merchant_invoices
  has_many :invoices, through: :merchant_invoices
  has_many :customers, through: :invoices
  
  validates_presence_of :name
end

# As a merchant and I 
# visit my merchant dashboard
# see the names of the 
# top 5 customers who have conducted the largest number of successful transactions
# next to each customer name I 
# see the number of successful transactions they have conducted with my merchant