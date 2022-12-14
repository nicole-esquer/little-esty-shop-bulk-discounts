require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it {should have_many(:invoices)}
  end

  describe 'class methods' do
    it 'lists the top 5 customers with transaction totals' do
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
    
      expect(Customer.top_customers).to eq([nicole, andre, brenna])
    end  
  end
end
