require 'rails_helper'

RSpec.describe 'Admin Merchant Show Page' do
  before do
    @merchant2 = Merchant.create!(name: "The Gibson Project")
  end
  it 'can click on the name of a merchant and go to its show page' do
    merchant = Merchant.create!(name: "Schroeder-Jerde")

    visit "/admin/merchants"
    #merchant = Merchant.create!(name: "Schroeder-Jerde")

    click_on "Schroeder-Jerde"

    expect(current_path).to eq("/admin/merchants/#{merchant.id}")
  end
  it "can see a link to update the merchants information" do

      visit "/admin/merchants/#{@merchant2.id}"
      click_on "Update Name"
      #expect(current_path).to eq("/admin/merchants/#{merchant.id}/edit")

      fill_in :name, with: ("Bob's Burgs")

      click_on("Save Update")


      expect("/admin/merchants/#{@merchant2.id}")
      expect(page).to have_content("Bob's Burgs")
    end

end
