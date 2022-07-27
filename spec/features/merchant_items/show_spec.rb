require 'rails_helper'

RSpec.describe "Merchant Item Show Page", type: :feature do
    it 'diplays item attributes name description selling price' do
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

        click_link("Basket Ball")

        expect(page).to have_current_path("/merchants/#{merchant_1.id}/items/#{item_1.id}")
        expect(page).to have_content("Basket Ball")
        expect(page).to have_content("Description: Wilson 29 in orange ball")
        expect(page).to have_content("Price: 45000")
        expect(page).to_not have_content("Kobe Bryant")
    end
end


# As a merchant,
# When I click on the name of an item from the merchant items index page,

#  Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)

#  And I see all of the item's attributes including:

# Name

# Description

# Current Selling Price
