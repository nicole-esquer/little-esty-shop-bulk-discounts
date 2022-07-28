class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items, source: :item

  enum status: { cancelled: 0, "in progress" => 1, completed: 2 }

  validates_presence_of :customer_id, :status

  def self.incomplete_invoices
    Invoice.joins(:invoice_items).where.not(invoice_items: {status: 2}).group(:id).select('invoices.*').order(created_at: :asc).limit(5)
  end

<<<<<<< HEAD
  top_five_customers
    customers.joins(:invoices).where(transactions: { result: :success}).limit(5)
=======
  def format_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def total_revenue
    invoice_items.sum("quantity * unit_price") / 100.0
>>>>>>> d29b03f5b4ed5f4f428a88d67a787405e8b7962f
  end
end
