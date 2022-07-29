require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
  end

  describe 'validations' do
    it { should validate_presence_of (:status) }
  end

  xit 'filters out incomplete invoices' do  
    sally = Customer.create!(first_name: "Sally", last_name: "Sunshine")
    invoice_1 = sally.invoices.create!(status: 1)
    invoice_2 = sally.invoices.create!(status: 1)

    expect(invoice_1.incomplete_invoices).to eq(true)
    expect(invoice_2.incomplete_invoices).to eq(true)
   end
end
