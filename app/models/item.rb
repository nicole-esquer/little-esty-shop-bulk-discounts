class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  scope :enabled, -> { where(status: 'enabled') }
  scope :disabled, -> { where(status: 'disabled') }
 
  enum status: { enabled: 0, disabled: 1 } 
  
  validates_presence_of :merchant_id, :name, :description, :unit_price
  validates :status, inclusion: { in: ["enabled", "disabled"] }
  # after_event :update_status

  private
    def update_status
      if item.status == 'enabled' 
        item.status = 'disabled'
      else
        item.status = 'enabled'
      end
    end

  # validates :status, inclusion: { in: ["enabled", "disabled"] }
end
