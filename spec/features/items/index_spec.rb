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

    it 'has top 5 highest earning revenue items' do
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
        item_3 = Item.create!(
            name: "Socks",
            description: "High Sockz Size 11",
            unit_price: 2000, merchant_id: merchant_1.id,
            status: 1)
        item_4 = Item.create!(
            name: "Head Bands",
            description: "Stretchy blue head bands",
            unit_price: 1500, merchant_id: merchant_1.id,
            status: 1)
        item_5 = Item.create!(
            name: "Water Bottle",
            description: "1 liter Jordan Water Bottle Red",
            unit_price: 1000, merchant_id: merchant_1.id,
            status: 1)
        item_6 = Item.create!(
            name: "Logos",
            description: "Iron on Jordan Logos",
            unit_price: 20000, merchant_id: merchant_1.id,
            status: 1)
        item_7 = Item.create!(
            name: "Lollipops",
            description: "Basketball Shape Lollipops",
            unit_price: 500, merchant_id: merchant_1.id,
            status: 1)

        nicole = Customer.create!(first_name: "Nicole", last_name: "Esquer")
        andre = Customer.create!(first_name: "Andre", last_name: "Pedro")
        brenna = Customer.create!(first_name: "Brenna", last_name: "Stuart")
        
        invoice_1 = Invoice.create!(customer_id: nicole.id, status: 2)
        invoice_2 = Invoice.create!(customer_id: andre.id, status: 2)
        invoice_3 = Invoice.create!(customer_id: brenna.id, status: 2)
        invoice_4 = Invoice.create!(customer_id: nicole.id, status: 1)
        
        nicole_invoice_item1 = InvoiceItem.create!(
            item_id: nicole.id, invoice_id: invoice_1.id, quantity: 1, 
            unit_price: item_1.unit_price, status: invoice_1.status)
        nicole_invoice_item2 = InvoiceItem.create!(
            item_id: nicole.id, invoice_id: invoice_1.id, quantity:2, 
            unit_price: item_2.unit_price, status: invoice_1.status)
        nicole_invoice4_item3 = InvoiceItem.create!(
            item_id: nicole.id, invoice_id: invoice_4.id, quantity: 10000, 
            unit_price: item_3.unit_price, status: invoice_4.status)
        andre_invoice_item4 = InvoiceItem.create!(
            item_id: andre.id, invoice_id:invoice_2.id, quantity: 1, 
            unit_price: item_4.unit_price, status: invoice_2.status)
        andre_invoice_item5 = InvoiceItem.create!(
            item_id: andre.id, invoice_id: invoice_2.id, quantity: 1, 
            unit_price: item_5.unit_price, status: invoice_2.status)
        andre_invoice_item6 = InvoiceItem.create!(
            item_id: andre.id, invoice_id: invoice_2.id, quantity:1, 
            unit_price: item_6.unit_price, status: invoice_2.status)
        brenna_invoice_item5 = InvoiceItem.create!(
            item_id: brenna.id, invoice_id: invoice_3.id, quantity:1, 
            unit_price: item_5.unit_price, status: invoice_3.status)
        brenna_invoice_item7 = InvoiceItem.create!(
            item_id: brenna.id, invoice_id: invoice_3.id, quantity:1, 
            unit_price: item_5.unit_price, status: invoice_3.status)
 


        visit merchants_items_path(merchant_1)

        expect(page).to have_content("Top 5 Items by Generate Renvenue:")

#blow is also the order of the highest revenue earned items
#item 3 was incomplete and did not make the cut
#item 7 dis not make the top 5 cut either since it had the lowest
        within "#top_5_items" do
        expect(page).to have_link("Jordans")
        expect(page).to have_link("Basket Ball")
        expect(page).to have_link("Logos")
        expect(page).to have_link("Water Bottle")
        expect(page).to have_link("Head Bands")
        expect(page).to_not have_content("Socks")
        expect(page).to_not have_content("Lollipops")
        end

     end


end





# As a merchant and when I visit my items index page

#  Then I see the names of the top 5 most popular items ranked by total revenue generated
#  And I see that each item name links to my merchant item show page for that item
#  And I see the total revenue generated next to each item name
# Notes on Revenue Calculation:

# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)