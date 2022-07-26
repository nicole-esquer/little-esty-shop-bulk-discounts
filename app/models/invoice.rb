class Invoice < ApplicationRecord
  belongs_to :customers

  validates_presence_of :customers_id, :status
end
