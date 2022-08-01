class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
 
  enum status: { disabled: 0, enabled: 1 } 
  
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

  def top_5_items
    # items.joins(invoice_items: :transactions).where(transactions: {result: "success"})
    # .group(:id).select("items.*, sum(quantity * invoice_items.unit_price) as revenue")
  end


  # validates :status, inclusion: { in: ["enabled", "disabled"] }
end
