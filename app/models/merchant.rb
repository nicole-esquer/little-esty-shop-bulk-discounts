class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items, source: :invoice_items
  has_many :customers, through: :invoice_items, source: :invoice
  has_many :transactions, through: :invoices
  
  has_many :invoices, through: :merchant_invoices
  
  validates_presence_of :name

  def top_five_customers
    # top five customers by number of successful transactions
    # customers who have conducted the most successful transactions
    customers.joins(:transactions).where(transactions: { result: :success }).group(:id).order("count(transactions.id) desc").limit(5)

  end
end

# As a merchant  I 
# visit my merchant dashboard
# see the names of the 
# top 5 customers who have conducted the largest number of successful transactions
# next to each customer name I 
# see the number of successful transactions they have conducted with my merchant