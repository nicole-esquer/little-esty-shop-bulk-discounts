class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, dependent: :destroy

  validates_presence_of :customer_id, :status

  enum status: { cancelled: 0, "in progress" => 1, completed: 2 }
end
