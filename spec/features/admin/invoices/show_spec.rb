require 'rails_helper'

RSpec.describe 'admin invoices show page' do
   before :each do
      @sally = Customer.create!(first_name: "Sally", last_name: "Sunshine")

      @invoice_1 = @sally.invoices.create!(status: 1)
      @invoice_2 = @sally.invoices.create!(status: 1)
      
   end

   it 'invoice show page includes invoice id, status, created_at date, and customers name' do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Invoice ID: #{@invoice_1.id}")
      expect(page).to have_content("Status: #{@invoice_1.status}")
      expect(page).to have_content("Customer's Full Name: #{@sally.first_name} #{@sally.last_name}")
      
      expect(page).to_not have_content("Invoice ID: #{@invoice_2.id}")
      expect(page).to_not have_content("Invoice Status: #{@invoice_2.status}")
  end
end


