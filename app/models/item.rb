class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
 
  enum status: { enabled: 0, disabled: 1 } 
  
  validates_presence_of :merchant_id, :name, :description, :unit_price
  validates :status, inclusion: { in: ["enabled", "disabled"] }
  # after_event :update_status

  def self.enabled_items(id)
    where(merchant_id: id, status: "enabled")
  end

  def self.disabled_items(id)
    where(merchant_id: id, status: "disabled")
  end

  def update_status(item)
    if item.status == 'enabled' 
      item.status = 'disabled'
      item.save
    elsif
      item.status =='disabled'
      item.status = 'enabled'
      item.save
    end
  end

  # validates :status, inclusion: { in: ["enabled", "disabled"] }
end
