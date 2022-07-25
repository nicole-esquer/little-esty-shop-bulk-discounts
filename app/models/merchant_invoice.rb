class MerchantInvoice < ApplicationRecord
  belongs_to :merchants
  belongs_to :invoices

  validates_presence_of :merchants_id, :invoices_id
end
