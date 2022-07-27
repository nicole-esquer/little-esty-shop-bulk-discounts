require 'rails_helper'

RSpec.describe "merchants show page", type: :feature do

  describe "merchant show dashboard" do
    it "returns http success" do
      merchant = Merchant.create!(name: "Joe")
      id = merchant.id
      
      visit "/merchants/#{id}/dashboard"

      expect(page).to have_content("#{merchant.name}")
    end
  end
end
