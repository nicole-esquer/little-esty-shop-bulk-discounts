require 'rails_helper'


RSpec.describe 'admin merchant index' do
    it 'When I visit the admin merchants index (/admin/merchants)' do
        visit "/admin/merchants"

        expect(current_path).to eq("/admin/merchants")

    end

    it 'I see the name of each merchant in the system' do
        merchant = Merchant.create!(name: "The Gibson Project")
        visit "/admin/merchants"

        expect(page).to have_content(merchant.name)
    end

    it 'when i visit, I see a button to disable or enable the merchant' do
        merchant = Merchant.create!(name: "The Gibson Project")

        visit "/admin/merchants"

        expect(current_path).to eq("/admin/merchants")
        #expect(page).to have_content("Disabled")
        expect(page).to have_button("Enable")
    end

    it 'when I visit the index page, I see two sections, one for enabled merchants and one for disable actions' do
        merchant1 = Merchant.create!(name: "The Gibson Project", status:"disabled")
        merchant2 = Merchant.create!(name: "The Allison Dream", status:"disabled")
        merchant3 = Merchant.create!(name: "The Peter Chronicles", status:"enabled")
        merchant4 = Merchant.create!(name: "The David Teeth", status:"enabled")

        visit "/admin/merchants"

        expect(page).to have_content("#{merchant1.name}")
        expect(page).to have_content("disabled")
        expect(page).to have_content("#{merchant2.name}")
        expect(page).to have_content("#{merchant2.status}")
        expect(page).to have_content("#{merchant3.name}")
        expect(page).to have_content("#{merchant3.status}")
        expect(page).to have_content("#{merchant4.name}")
        expect(page).to have_content("enabled")
    end

    it ' Admin has top 5 merchants based on revenue generated' do
        merchant_1 = Merchant.create!(name: "Micheal Jordan", status: "enabled")
        merchant_2 = Merchant.create!(name: "Kobe Bryant", status: "enabled")
        merchant_3 = Merchant.create!(name: "Shaquille Oneal", status: "enabled")
        merchant_4 = Merchant.create!(name: "Steph Curry", status: "enabled")
        merchant_5 = Merchant.create!(name: "Lebron James", status: "enabled")
        merchant_6 = Merchant.create!(name: "Kevin Durant", status: "enabled")
        merchant_7 = Merchant.create!(name: "Magic Johnson", status: "enabled")

        item_1 = merchant_1.items.create!(merchant_id: merchant_1.id, name: "Item 1", description: "its the 1st item", unit_price: 100, status: 1)
        item_2 = merchant_2.items.create!(merchant_id: merchant_2.id, name: "Item 2", description: "its the 2nd item", unit_price: 40000, status: 1)
        item_3 = merchant_3.items.create!(merchant_id: merchant_3.id, name: "Item 3", description: "its the 3rd item", unit_price: 1000, status: 1) 
        item_4 = merchant_4.items.create!(merchant_id: merchant_4.id, name: "Item 4", description: "its the 4th item", unit_price: 10000, status: 1)
        item_5 = merchant_5.items.create!(merchant_id: merchant_5.id, name: "Item 5", description: "its the 5th item", unit_price: 2000, status: 1)
        item_6 = merchant_6.items.create!(merchant_id: merchant_6.id, name: "Item 6", description: "its the 6th item", unit_price: 300, status: 1)
        item_7 = merchant_7.items.create!(merchant_id: merchant_7.id, name: "Item 7", description: "its the 7th item", unit_price: 600, status: 1)
        item_8 = merchant_3.items.create!(merchant_id: merchant_3.id, name: "Item 8", description: "its the 8th item", unit_price: 250, status: 1)
        
        nicole = Customer.create!(first_name: "Nicole", last_name: "Esquer")
        andre = Customer.create!(first_name: "Andre", last_name: "Pedro")
        brenna = Customer.create!(first_name: "Brenna", last_name: "Stuart")

        invoice_1 = Invoice.create!(customer_id: nicole.id, status: 2)
        invoice_2 = Invoice.create!(customer_id: andre.id, status: 2)
        invoice_3 = Invoice.create!(customer_id: brenna.id, status: 2)
        invoice_4 = Invoice.create!(customer_id: nicole.id, status: 0)

        invoice1_transaction_1 = invoice_1.transactions.create!(result: 0, credit_card_number: 983475, credit_card_expiration_date: nil)
        invoice2_transaction_2 = invoice_2.transactions.create!(result: 0, credit_card_number: 982345, credit_card_expiration_date: nil)
        invoice3_transaction_3 = invoice_3.transactions.create!(result: 0, credit_card_number: 912432, credit_card_expiration_date: nil)
        invoice4_transaction_4 = invoice_4.transactions.create!(result: 1, credit_card_number: 534575, credit_card_expiration_date: nil)

        nicole_invoice_item1 = item_1.invoice_items.create!(
            item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, 
            unit_price: item_1.unit_price, status: 2)
        nicole_invoice_item2 = item_2.invoice_items.create!(
            item_id: item_2.id, invoice_id: invoice_1.id, quantity:2, 
            unit_price: item_2.unit_price, status: 2)
        nicole_invoice4_item3 = item_3.invoice_items.create!(
            item_id: item_3.id, invoice_id: invoice_4.id, quantity: 10000, 
            unit_price: item_3.unit_price, status: 0)
        andre_invoice_item4 = item_4.invoice_items.create!(
            item_id: item_4.id, invoice_id:invoice_2.id, quantity: 1, 
            unit_price: item_4.unit_price, status: 2)
        andre_invoice_item5 = item_5.invoice_items.create!(
            item_id: item_5.id, invoice_id: invoice_2.id, quantity: 1, 
            unit_price: item_5.unit_price, status: 2)
        andre_invoice_item6 = item_6.invoice_items.create!(
            item_id: item_6.id, invoice_id: invoice_2.id, quantity:1, 
            unit_price: item_6.unit_price, status: 2)
        brenna_invoice_item5 = item_5.invoice_items.create!(
            item_id: item_5.id, invoice_id: invoice_3.id, quantity:2, 
            unit_price: item_5.unit_price, status: 2)
        brenna_invoice_item7 = item_7.invoice_items.create!(
            item_id: item_7.id, invoice_id: invoice_3.id, quantity:1, 
            unit_price: item_7.unit_price, status: 2)
        brenna_invoice_item8 = item_8.invoice_items.create!(
            item_id: item_8.id, invoice_id: invoice_3.id, quantity:1, 
            unit_price: item_8.unit_price, status: 2)

        visit "/admin/merchants"
      

        expect(page).to have_content("Top 5 Merchants by Generated Revenue:")

        within "#top_5_merchants" do
        expect(page).to have_link("Kobe Bryant")
        expect(page).to have_link("Steph Curry")
        expect(page).to have_link("Lebron James")
        expect(page).to have_link("Magic Johnson")
        expect(page).to have_link("Kevin Durant")
        expect(page).to_not have_link("Shaquille Oneal")     
        expect(page).to_not have_link("Michael Jordan")

        expect(merchant_2.name).to appear_before(merchant_5.name)
        expect(merchant_5.name).to appear_before(merchant_4.name)
        expect(merchant_4.name).to appear_before(merchant_7.name)
        expect(merchant_7.name).to appear_before(merchant_6.name)
        end
    end
end
