require 'rails_helper'

RSpec.describe "merchant/show.html.erb", type: :view do
  
  describe "merchant show dashboard" do
    it "returns http success" do
      merchant = Merchant.create!(name: "Joe")
      id = merchant.id

      visit merchant_dashboard_path(id)

      expect(page).to have_content("#{merchant.name}")
    end
  end
end
