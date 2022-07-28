class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items, source: :item
  has_many :transactions

  enum status: { cancelled: 0, "in progress" => 1, completed: 2 }

  validates_presence_of :customer_id, :status

  def self.incomplete_invoices
    Invoice.joins(:invoice_items).where.not(invoice_items: {status: 2}).group(:id).select('invoices.*').order(created_at: :asc).limit(5)
  end

  top_five_customers
    customers.joins(:invoices).where(transactions: { result: :success}).limit(5)
  end
end
