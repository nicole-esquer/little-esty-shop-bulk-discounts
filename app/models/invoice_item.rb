class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  has_one :transactions, through: :invoice
  
  scope :created_at_desc, -> { order(created_at: :desc) }

  enum status: { packaged: 0, pending: 1, shipped: 2 }

  validates_presence_of :item_id, :invoice_id, :quantity, :unit_price

  def format_date
    created_at.strftime("%A, %B %d, %Y")
  end
end
