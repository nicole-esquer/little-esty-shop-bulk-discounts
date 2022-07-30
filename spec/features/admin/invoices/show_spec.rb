require 'rails_helper'

RSpec.describe 'admin invoices show page' do
   before :each do
      @merchant_1 = Merchant.create!(name: "merchant_1")

      @item_1 = @merchant_1.items.create!(name: "Item 1", description: "its the 1st item", unit_price: 10000)
      @item_2 = @merchant_1.items.create!(name: "Item 2", description: "its the 2nd item", unit_price: 2000)
      @item_3 = @merchant_1.items.create!(name: "Item 3", description: "its the 3rd item", unit_price: 300)

      @sally = Customer.create!(first_name: "Sally", last_name: "Sunshine")

      @invoice_1 = @sally.invoices.create!(status: 1)
      @invoice_2 = @sally.invoices.create!(status: 1)

      @invoice_items_1 = @item_1.invoice_items.create!(quantity: 1, unit_price: 10000, status: "pending", invoice_id: @invoice_1.id)
      @invoice_items_2 = @item_2.invoice_items.create!(quantity: 1, unit_price: 2000, status: "pending", invoice_id: @invoice_2.id)
      @invoice_items_3 = @item_3.invoice_items.create!(quantity: 1, unit_price: 300, status: "pending", invoice_id: @invoice_1.id)
      
   end

   it 'invoice show page includes invoice id, status, created_at date, and customers name' do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
      expect(page).to have_content("Status: #{@invoice_1.status}")
      expect(page).to have_content("Customer's Full Name: #{@sally.first_name} #{@sally.last_name}")
      
      expect(page).to_not have_content("Invoice ID: #{@invoice_2.id}")
      expect(page).to_not have_content("Invoice Status: #{@invoice_2.status}")
  end

   it "has all items on the invoice w/item name, quantity, price, and invoice item status" do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Name: Item 1")
      expect(page).to have_content("Name: Item 3")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Price: $10000")
      expect(page).to have_content("Price: $300")
      expect(page).to have_content("Item Status: pending")

      expect(page).to_not have_content("Name: Item 2")
      expect(page).to_not have_content("Price: $2000")
   end

   it 'shows the total revenue from all items on specific invoice' do
      visit admin_invoice_path(@invoice_1)
          
      expect(page).to have_content("Total Revenue: 103.0")
   end
end


