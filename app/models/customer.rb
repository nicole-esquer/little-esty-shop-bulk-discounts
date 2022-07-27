class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoices, source: :invoice_items
  has_many :merchants, through: :invoices

  validates_presence_of :first_name, :last_name
  
  def successful_transactions
    joins(:invoices, :transactions, as: :transactions_count).where(transactions: {result: :success}).group(:id).order(:transactions_count).limit(5)
    joins(:invoices, :transactions).select(:customers).where(transactions: {result: :success}).group(:customers).order(:transactions).limit(5)
  end
end
