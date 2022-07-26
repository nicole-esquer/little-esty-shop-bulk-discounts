require 'rails_helper'

RSpec.describe "merchants items index page", type: :feature do
    it 'has a list of names of all items does not show items from other merchants' do 

        merchant_1 = Merchant.create!(name: "Micheal Jordan")
        merchant_2 = Merchant.create!(name: "Kobe Bryant")

        item_1 = Item.create!(
            name: "Basket Ball", 
            description: "Wilson 29 in orange ball", 
            unit_price: 25000, merchant_id: merchant_1.id)
        item_2 = Item.create!(
            name: "Jordans", 
            description: "High quality size 11 athletic shoes", 
            unit_price: 45000, merchant_id: merchant_1.id)
        item_3 = Item.create!(
            name: "Basket Ball", 
            description: "Wilson 29 in orange ball", 
            unit_price: 25000, merchant_id: merchant_2.id)
        item_4 = Item.create!(
            name: "Jersey", 
            description: "Size L stain resistant jersey", 
            unit_price: 20000, merchant_id: merchant_2.id)

        visit "/merchants/#{merchant_1.id}/items"

        within "#items-#{item_1.id}" do
        expect(page).to have_content("Basket Ball")
        expect(page).to_not have_content("Jersey")
        end
        
        within "#items-#{item_2.id}" do
        expect(page).to have_content("Jordans")
        expect(page).to_not have_content("Jersey")
        end
    end
end


#  As a merchant and I visit my merchant items index page ("merchants/merchant_id/items")
#  I see a list of the names of all of my items
#  And I do not see items for any other merchant
