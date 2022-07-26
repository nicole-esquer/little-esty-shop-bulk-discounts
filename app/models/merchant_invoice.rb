class MerchantInvoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :invoice

  validates_presence_of :merchant_id, :invoice_id
end
