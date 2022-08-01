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

  # def top_5_items #by highest revenue produced
  #   invoice_items.where(status: :package || :shipped)
  #   items.select(
  # end
end
