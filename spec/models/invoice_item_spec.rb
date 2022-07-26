require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "relationships" do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
  end
end
