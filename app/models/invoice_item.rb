class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  has_one :transactions, through: :invoice
  
  scope :created_at_desc, -> { order(created_at: :desc) }

  enum status: { "pending" => 0, "packaged" => 1, "shipped" => 2 }

  validates_presence_of :item_id, :invoice_id, :quantity, :unit_price
  validates :status, inclusion: { in: ["packaged", "pending", "shipped"] }

end
