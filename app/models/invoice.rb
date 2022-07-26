class Invoice < ApplicationRecord
  belongs_to :customer

  #validates_presence_of :customer_id, :status
end
