class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
 
  validates_presence_of :merchant_id, :name, :description, :unit_price

  enum status: { enabled: 0, disabled: 1 } do
    event :disable do
      transition enabled: :disabled
    end
    event :enable do
      transition disabled: :enabled
    end
  end

  <%= form_with(model: inv_item, local: true) do |form| %>
    <td><%= form.select :status, options_for_select(InvoiceItem.statuses.keys, inv_item.status) %>
    <%= form.submit "Update Item Status" %></td>
  <% end %>

  # validates :status, inclusion: { in: ["enabled", "disabled"] }
end
