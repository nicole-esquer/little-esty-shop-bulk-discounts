class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy

  validates_presence_of :first_name, :last_name

  def top_5_customers
    # require 'pry'; binding.pry
  end
end
