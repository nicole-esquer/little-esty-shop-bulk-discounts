require 'rails_helper'

RSpec.describe "merchants show page", type: :feature do

  describe "merchant show dashboard" do
    it "shows the merchants name" do
      merchant = Merchant.create!(name: "Joe")
      id = merchant.id
      
      visit "/merchants/#{id}/dashboard"
      
      expect(page).to have_content("#{merchant.name}")
    end
    
    it "has a link to the merchants items" do
      merchant = Merchant.create!(name: "Joe")

      visit "/merchants/#{merchant.id}/dashboard"
      
      expect(page).to have_link("Items")
    end
    
    it "has a link to the merchants invoices" do
      merchant = Merchant.create!(name: "Joe")

      visit "/merchants/#{merchant.id}/dashboard"

      expect(page).to have_link("Invoices")
    end
  end