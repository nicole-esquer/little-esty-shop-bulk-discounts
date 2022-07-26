class InvoiceItem < ApplicationRecord
  belongs_to :items
  belongs_to :invoices

  validates_presence_of :quantity, :unit_price, :status, :item_id, :invoice_id
end
