require 'rails_helper'

RSpec.describe 'Admin Merchant Show Page' do
  it 'can click on the name of a merchant and go to its show page' do
    merchant = Merchant.create!(name: "The Gibson Project")

    visit "/admin/merchants"

    click_on merchant.name

    expect(current_path).to eq("/admin/merchants/#{merchant.id}")
  end
  it "can see a link to update the merchants information" do
      merchant = Merchant.create!(name: "The Gibson Project")

      visit "/admin/merchants/#{merchant.id}"

      click_on "Update Merchant"
      #expect(current_path).to eq("/admin/merchants/#{merchant.id}/edit")

      fill_in "Name", with: ("Bob's Burgs")

      #click_on("Save Update")

      expect("/admin/merchants/#{merchant.id}")
      expect(page).to have_content("Bob's Burgs")
    end

end
