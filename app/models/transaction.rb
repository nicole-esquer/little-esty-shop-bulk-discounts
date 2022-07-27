class Transaction < ApplicationRecord
  belongs_to :invoice

  has_one :customer, through: :invoice
  # has_one :merchant, through: :invoice

  has_many :invoice_items, through: :invoice
  
  enum result: { success: 0, failed: 1 }

  validates_presence_of :invoice_id, :credit_card_number, :result
end
