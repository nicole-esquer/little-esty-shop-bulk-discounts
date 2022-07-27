class Merchant < ApplicationRecord
  # has_many :merchant_invoices

  has_many :items
  
  has_many :invoices
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  
  validates_presence_of :name

  def top_five_customers
    customers.joins(:invoices, :transactions).where(transactions: {result: "success"}).order(customers.num_successful_transactions).limit(5)
  end
end

# As a merchant  I 
# visit my merchant dashboard
# see the names of the 
# top 5 customers who have conducted the largest number of successful transactions
# next to each customer name I 
# see the number of successful transactions they have conducted with my merchant