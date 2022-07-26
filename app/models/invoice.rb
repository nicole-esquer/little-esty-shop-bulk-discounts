class Invoice < ApplicationRecord
  belongs_to :customer

  enum status: { cancelled: 0, in_progress: 1, completed: 2 }

  validates_presence_of :customer_id, :status, :created_at, :updated_at
end
