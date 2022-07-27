class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices, dependent: :destory

  def top_5_customers
    require 'pry'; binding.pry
  end
end
