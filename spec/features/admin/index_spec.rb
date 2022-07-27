require 'rails_helper'

RSpec.describe 'admin dashboard' do
   it 'has a header titled admin dashboard' do
      visit '/admin'

      expect(page).to have_content("Admin Dashboard")
   end

   it 'has a link to the admin merchants index (/admin/merchants)' do
      visit '/admin'
      click_on 'Admin Merchants'

      expect(current_path).to eq(admin_merchants_path)
   end

    it 'has a link to the admin merchants index (/admin/invoices)' do
      visit '/admin'
      click_on 'Admin Invoices'

      expect(current_path).to eq(admin_invoices_path)
   end

   describe 'dashboard statistics - top customers' do
      xit 'displays the names of the top 5 customers' do
         visit '/admin'
  
         expect(page).to have_content("Top 5 Customers")

         sally = Customer.create!(first_name: "Sally", last_name: "Sunshine")
         henry = Customer.create!(first_name: "Henry", last_name: "Hill")
         tom = Customer.create!(first_name: "Tom", last_name: "Thunder")
         mary = Customer.create!(first_name: "Mary", last_name: "Mountain")
         riley = Customer.create!(first_name: "Riley", last_name: "Rain")
   
         invoice_1 = sally.invoices.create!(status: "In Progress")
         invoice_2 = sally.invoices.create!(status: "Completed")
         invoice_3 = sally.invoices.create!(status: "Cancelled")
         invoice_4 = henry.invoices.create!(status: "Completed")
         invoice_5 = tom.invoices.create!(status: "Completed")
         invoice_6 = tom.invoices.create!(status: "Completed")
         invoice_7 = mary.invoices.create!(status: "Completed")
         invoice_8 = mary.invoices.create!(status: "Completed")
         invoice_9 = mary.invoices.create!(status: "Completed")
         invoice_10 = mary.invoices.create!(status: "Completed")

         expect(page).to have_content("Sally - 1 Purchases")
      end
   end

   describe 'Admin Dashboard Invoices' do
      it 'has the "Incomplete Invoices" section w/ list of IDs for all invoices with unshipped items' do
         sally = Customer.create!(first_name: "Sally", last_name: "Sunshine")
         henry = Customer.create!(first_name: "Henry", last_name: "Hill")

         invoice_1 = sally.invoices.create!(status: 1)
         invoice_2 = sally.invoices.create!(status: 1)
         invoice_3 = sally.invoices.create!(status: 1)
         invoice_4 = henry.invoices.create!(status: 2)

         visit '/admin'

         expect(page).to have_content("Incomplete Invoices")
   
         expect(page).to have_content(@invoice_1)
         expect(page).to have_content(@invoice_2)
         expect(page).to have_content(@invoice_3)

         expect(page).to_not have_content(@invoice_4)
      end

      xit 'each invoice id links to that invoices admin show page' do
   
      end
   end
end