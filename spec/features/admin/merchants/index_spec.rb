require 'rails_helper'


RSpec.describe 'admin merchant index' do
  it 'When I visit the admin merchants index (/admin/merchants)' do
    visit "/admin/merchants"

    expect(current_path).to eq("/admin/merchants")

  end

  it 'I see the name of each merchant in the system' do
    merchant = Merchant.create!(name: "The Gibson Project")
    visit "/admin/merchants"

    expect(page).to have_content(merchant.name)
  end

  it 'can click on the name of a merchant and go to its show page' do
    merchant = Merchant.create!(name: "The Gibson Project")

    visit "/admin/merchants"

    click_on merchant.name

    expect(current_path).to eq("/admin/merchants/merchant_id")
    save_and_open_page
  end

end
