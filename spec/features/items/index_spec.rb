require 'rails_helper'

RSpec.describe "merchants items index page", type: :feature do
    it 'has a list of names of all items does not show items from other merchants' do

        merchant_1 = Merchant.create!(name: "Micheal Jordan")
        merchant_2 = Merchant.create!(name: "Kobe Bryant")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id,
            status: 1)
        item_2 = Item.create!(
            name: "Jordans",
            description: "High quality size 11 athletic shoes",
            unit_price: 45000, merchant_id: merchant_1.id,
            status: 1)
        item_3 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_2.id)
        item_4 = Item.create!(
            name: "Jersey",
            description: "Size L stain resistant jersey",
            unit_price: 20000, merchant_id: merchant_2.id)

        visit merchants_items_path(merchant_1)

        within "#enable-#{item_1.id}" do
        expect(page).to have_content("Basket Ball")
        expect(page).to_not have_content("Jersey")
        end

        within "#enable-#{item_2.id}" do
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

        visit merchants_items_path(merchant_1)

        expect(page).to have_link("Basket Ball")
        expect(page).to have_link("Jordans")
        expect(page).to_not have_link("Jersey")
    end

    it 'enable items have a disable button that changes status to disable' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id,
            status: 1)
        item_2 = Item.create!(
            name: "Jordans",
            description: "High quality size 11 athletic shoes",

            unit_price: 45000, merchant_id: merchant_1.id,
            status: 1)

            

        visit merchants_items_path(merchant_1)
        

        within("#enable-#{item_1.id}") do
        click_on("Disable")
        expect(current_path).to eq(merchants_items_path(merchant_1))
        end
      

        within("#disable-#{item_1.id}") do
        expect(page).to have_content("Basket Ball")
        # expect(item_1.status).to eq("disabled")
        end

    end

    it 'disable items have a enable button that changes status to enable' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id,
            status: 0)

        item_2 = Item.create!(
            name: "Jordans",
            description: "High quality size 11 athletic shoes",
            unit_price: 45000, merchant_id: merchant_1.id,
            status: 0)
   
        visit merchants_items_path(merchant_1)

        within("#disable-#{item_2.id}") do
        click_on("Enable")

        expect(current_path).to eq(merchants_items_path(merchant_1))
        end
        # expect(item_2.status).to eq("enabled")
    end

    it 'display 2 sections called enabled items and disabled items' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id,
            status:1)
        item_2 = Item.create!(
            name: "Jordans",
            description: "High quality size 11 athletic shoes",
            unit_price: 45000, merchant_id: merchant_1.id)

        visit merchants_items_path(merchant_1)

        expect(page).to have_content("Enabled Items")
        expect(page).to have_content("Disabled Items")
    end


    it 'has enabled items in the enabled section and disable items in disabled section' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id,
            status: 1)
        item_2 = Item.create!(
            name: "Jordans",
            description: "High quality size 11 athletic shoes",
            unit_price: 45000, merchant_id: merchant_1.id,
            status: 0)

        visit merchants_items_path(merchant_1)


        within("#enable-#{item_1.id}") do
        expect(page).to have_link("Basket Ball")
        expect(page).to_not have_link("Jordans")
        end

        within("#disable-#{item_2.id}") do
        expect(page).to have_link("Jordans")
        expect(page).to_not have_link("Basket Ball")
        end
    end


    it 'has a button to create new item' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id)

        visit merchants_items_path(merchant_1)

        click_on("Create a New Item")
        expect(current_path).to eq(new_merchants_item_path(merchant_1))
    end
   
    it 'creates new item with default status of diabled' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id)

        visit merchants_items_path(merchant_1)

        click_on("Create a New Item")
        fill_in 'Name', with: 'Toy Doll'
        fill_in 'Description', with: '8in Speaking Amy Doll'
        select "enabled", :from => "Status"
        fill_in "Unit price", with: 10
        click_button 'Save'
        expect(current_path).to eq(merchants_items_path(merchant_1))
        expect(item_1.status).to eq("disabled")
    end
   
    it 'dispalys new item on merchant item index page' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan")

        item_1 = Item.create!(
            name: "Basket Ball",
            description: "Wilson 29 in orange ball",
            unit_price: 25000, merchant_id: merchant_1.id)

        visit merchants_items_path(merchant_1)

        click_on("Create a New Item")
        fill_in 'Name', with: 'Toy Doll'
        fill_in 'Description', with: '8in Speaking Amy Doll'
        select "enabled", :from => "Status"
        fill_in "Unit price", with: 10
        click_button 'Save'
        expect(page).to have_content(item_1.name)
    end


end



