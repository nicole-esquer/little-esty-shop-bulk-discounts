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
        expect(page).to have_content("Price: 25000")
        expect(page).to_not have_content("Kobe Bryant")
    end

    describe 'can update merchant item info' do
        it 'has a link to update the item info' do
            merchant_2 = Merchant.create!(name: "Kobe Bryant")
            item_3 = Item.create!(
            name: "Basket Ball", 
            description: "Wilson 29 in orange ball", 
            unit_price: 25000, merchant_id: merchant_2.id)
            item_4 = Item.create!(
            name: "Jersey", 
            description: "Size L stain resistant jersey", 
            unit_price: 20000, merchant_id: merchant_2.id)

            visit "/merchants/#{merchant_2.id}/items/#{item_3.id}"
            click_link 'Update'
            
            expect(current_path).to eq("/merchants/#{merchant_2.id}/items/#{item_3.id}/edit")

        end
        it 'has a form with existing attributes info filled in' do
            merchant_2 = Merchant.create!(name: "Kobe Bryant")
            item_3 = Item.create!(
            name: "Basket Ball", 
            description: "Wilson 29 in orange ball", 
            unit_price: 25000, merchant_id: merchant_2.id)
            item_4 = Item.create!(
            name: "Jersey", 
            description: "Size L stain resistant jersey", 
            unit_price: 20000, merchant_id: merchant_2.id)

            visit ("/merchants/#{merchant_2.id}/items/#{item_3.id}/edit")
        
            expect(find('form')).to have_content('Name')
            expect(find('form')).to have_content('Description')
            expect(find('form')).to have_content('Price')
            expect(find('form')).to_not have_content('Jersey')

        end
    end
end
# As a merchant,
# When I visit the merchant show page of an item

#  I see a link to update the item information.

#  When I click the link
# Then I am taken to a page to edit this item

#  And I see a form filled in with the existing item attribute information

#  When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information

#  And I see a flash message stating that the information has been successfully updated.
