require 'rails_helper'

RSpec.describe 'admin invoices index' do
  it 'index page' do
      visit "/admin/invoices"
   
      expect(current_path).to eq("/admin/invoices")
  end

   it 'has list of all Invoice ids in the system' do
      sally = Customer.create!(first_name: "Sally", last_name: "Sunshine")

      invoice_1 = sally.invoices.create!(status: 1)
      invoice_2 = sally.invoices.create!(status: 1)
      invoice_3 = sally.invoices.create!(status: 1) 
         
      visit admin_invoices_path

      expect(page).to have_content(invoice_1.id)
      expect(page).to have_content(invoice_2.id)
      expect(page).to have_content(invoice_3.id)
   end
end
