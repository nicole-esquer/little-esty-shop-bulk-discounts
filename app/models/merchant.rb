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

  def self.enabled_merchants(id)
    where(merchant_id: id, status: "enabled")
  end

  def self.disabled_merchants(id)
    where(merchant_id: id, status: "disabled")
  end

end
