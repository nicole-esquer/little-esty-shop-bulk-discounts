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
end