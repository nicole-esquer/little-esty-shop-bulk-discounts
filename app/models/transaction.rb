class Transaction < ApplicationRecord
  belongs_to :invoice
  
  enum result: { success: 0, failed: 1 }

  validates_presence_of :invoice_id, :credit_card_number, :result
end
