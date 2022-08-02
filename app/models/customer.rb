class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoices, source: :invoice_items
  has_many :merchants, through: :invoices

  validates_presence_of :first_name, :last_name

  def successful_transactions
    where(invoices: {status: :completed}, transactions: {result: :success})
  end

  def self.top_customers
    joins(:transactions)
    .where(transactions: {result: 0})
    .select("customers.*, count(transactions) as success_count")
    .group(:id)
    .order(success_count: :desc)
    .limit(5)
  end
end

