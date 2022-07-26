class Transaction < ApplicationRecord
  belongs_to :invoice
  
  enum result: { success: 0, failed: 1 }

  validates_presence_of :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at
end
