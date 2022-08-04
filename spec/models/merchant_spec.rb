require 'rails_helper'

RSpec.describe Merchant, type: :model do  
  describe 'relationships' do
    it { should have_many(:items) }
    # it { should have_many(:merchant_invoices) }
    it { should have_many(:invoices) }
    it { should have_many(:customers) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

   describe 'merchant methods' do
    it 'has top 5 merchants based on revenue' do
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
            
      merchants = Merchant.all
      
      actual = merchants.top_5_merchants.map do |merchant|
        merchant.name
      end
      top_5_merchant_names = [merchant_2.name, merchant_5.name, merchant_4.name, merchant_7.name, merchant_6.name]
      expect(actual).to eq(top_5_merchant_names)
    end
      
    it 'has top 5 items based on revenue produced' do
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
          item_id: item_5.id, invoice_id: invoice_3.id, quantity:1, 
          unit_price: item_5.unit_price, status: 1)
      brenna_invoice_item7 = item_7.invoice_items.create!(
          item_id: item_7.id, invoice_id: invoice_3.id, quantity:1, 
          unit_price: item_5.unit_price, status: 1)

      
      actual = merchant_1.top_5_items.map do |item|
        item.name
      end
      top_5_item_names = [item_2.name, item_1.name, item_6.name, item_5.name, item_4.name]
      
      expect(actual).to eq(top_5_item_names)
    end
  end
end
 ["Jordans", "Basket Ball", "Logos", "Water Bottle", "Head Bands"]