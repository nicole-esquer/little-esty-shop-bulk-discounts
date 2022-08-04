require 'rails_helper'

RSpec.describe "can update merchant item info", type: :feature do
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
        expect(find('form')).to have_content('Unit price')
        # expect(page).to have_content('Basketball')
        expect(find('form')).to_not have_content('Jersey')
    end

    it 'redirects back to show page with updated info' do
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

        fill_in 'Name', with: 'Kid Ball'
        fill_in 'Description', with: '7in kids size Purple Ball'



        click_on 'Save'

        expect(page).to have_current_path("/merchants/#{merchant_2.id}/items/#{item_3.id}")
        expect(page).to have_content('Kid Ball')
        expect(page).to have_content('7in kids size Purple Ball')
        expect(page).to have_content(25000)
        expect(page).to_not have_content('Wilson 29 in orange ball')

    end
end