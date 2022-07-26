require 'rails_helper'

RSpec.describe MerchantInvoice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "relationships" do
    it {should belong_to :merchant}
    it {should belong_to :invoice}
  end
end
