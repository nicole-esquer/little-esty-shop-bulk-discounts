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

        visit merchant_items_path(merchant_1)

        within "#items-#{item_1.id}" do
        expect(page).to have_content("Basket Ball")
        expect(page).to_not have_content("Jersey")
        end

        within "#items-#{item_2.id}" do
        expect(page).to have_content("Jordans")
        expect(page).to_not have_content("Jersey")
        end
    end

    it 'links to each items show page' do
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

        visit merchant_items_path(merchant_1)

        expect(page).to have_link("Basket Ball")
        expect(page).to have_link("Jordans")
        expect(page).to_not have_link("Jersey")
    end

    it 'each item has a enabled button that changes status to enabled' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id)
        item_2 = Item.create!(
            name: "Jordans",
            description: "High quality size 11 athletic shoes",
            unit_price: 45000, merchant_id: merchant_1.id)

        visit merchant_items_path(merchant_1)

        within("#item-#{item_1.id}") do
        click_button("Enable")
      end
        expect(current_path).to eq(merchant_items_path(merchant_1))
        expect(item_1.status).to eq("enabled")
    end

    it 'each item has a diabled button that changes status to disabled' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id)
        item_2 = Item.create!(
            name: "Jordans",
            description: "High quality size 11 athletic shoes",
            unit_price: 45000, merchant_id: merchant_1.id)

        visit merchant_items_path(merchant_1)

        within("#item-#{item_2.id}") do
        click_button("Disable")
      end
        expect(current_path).to eq(merchant_items_path(merchant_1))
        expect(item_2.status).to eq("disabled")
    end

    it 'display 2 sections called enabled items and disabled items' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id)
        item_2 = Item.create!(
            name: "Jordans",
            description: "High quality size 11 athletic shoes",
            unit_price: 45000, merchant_id: merchant_1.id)

        visit merchant_items_path(merchant_1)

        expect(page).to have_content("Enabled Items")
        expect(page).to have_content("Disabled Items")
    end


    it 'has enabled items in the enabled section and disable items in disabled section' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id)
        item_2 = Item.create!(
            name: "Jordans",
            description: "High quality size 11 athletic shoes",
            unit_price: 45000, merchant_id: merchant_1.id)

        visit "/merchants/#{@merchant_1.id}/items"

        within("#item-#{item_1.id}") do
        click_button("Enable")
      end
        within '#enableditems' do
        expect(page).to have_link("Basket Ball")
        expect(page).to_not have_link("Jordans")
        end

        within("#item-#{item_2.id}") do
        click_button("Disable")
      end
        within '#disableditems' do
        expect(page).to have_link("Jordans")
        expect(page).to_not have_link("Basket Ball")
        end

  end
end




# As a merchant
# When I visit my items index page
#  Next to each item name I see a button to disable or enable that item.
#  When I click this button
# Then I am redirected back to the items index
#  And I see that the items status has changed

#  As a merchant and I visit my merchant items index page ("merchants/merchant_id/items")
#  I see a list of the names of all of my items (with link to item)
#  And I do not see items for any other merchant
