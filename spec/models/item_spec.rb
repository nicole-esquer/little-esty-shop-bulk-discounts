require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
  end
end
