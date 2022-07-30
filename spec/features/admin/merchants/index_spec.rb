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

  it 'when i visit, I see a button to disable or enable the merchant' do
    merchant = Merchant.create!(name: "The Gibson Project")

    visit "/admin/merchants"

    expect(current_path).to eq("/admin/merchants")
    expect(page).to have_content("Disabled")
    expect(page).to have_content("Enabled")
  end







end
