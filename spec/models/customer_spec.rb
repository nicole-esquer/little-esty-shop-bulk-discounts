require 'rails_helper'

RSpec.describe Customer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "relationships" do
    it {should have_many(:invoices)}
  end
end
