class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items, source: :invoice_items
  has_many :customers, through: :invoice_items, source: :invoice
  has_many :transactions, through: :invoices

  validates_presence_of :name, presence: true

  def top_five_customers
    # customers.select('customers.*, count(transactions.result) as success_count') joins(:invoices).where(transactions: { result: :success}).limit(5)
  end

  def items_ready_to_ship
    invoice_items.where(status: :packaged)
  end
end

# section for "Items Ready to Ship"
# a list of the names of all of my items
# ordered and have not yet been shipped,
# And next to each Item I see the id of the invoice that ordered my item
# And each invoice id is a link to my merchant's invoice show page

# As a merchant  I
# visit my merchant dashboard
# see the names of the
# top 5 customers who have conducted the largest number of successful transactions
# next to each customer name I
# see the number of successful transactions they have conducted with my merchant
