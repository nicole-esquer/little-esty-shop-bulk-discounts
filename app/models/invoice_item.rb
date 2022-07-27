class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoices

  validates_presence_of :item_id, :invoice_id, :quantity, :unit_price

  enum status: { packaged: 0, pending: 1, shipped: 2 }

  def status_not_shipped
    where
  end
end
