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
    #expect(page).to have_content("Disabled")
    expect(page).to have_button("Enable")
  end

  it 'when I visit the index page, I see two sections, one for enabled merchants and one for disable actions' do

  merchant1 = Merchant.create!(name: "The Gibson Project", status:"disabled")
  merchant2 = Merchant.create!(name: "The Allison Dream", status:"disabled")
  merchant3 = Merchant.create!(name: "The Peter Chronicles", status:"enabled")
  merchant4 = Merchant.create!(name: "The David Teeth", status:"enabled")

  visit "/admin/merchants"

  expect(page).to have_content("#{merchant1.name}")
  expect(page).to have_content("disabled")
  expect(page).to have_content("#{merchant2.name}")
  expect(page).to have_content("#{merchant2.status}")
  expect(page).to have_content("#{merchant3.name}")
  expect(page).to have_content("#{merchant3.status}")
  expect(page).to have_content("#{merchant4.name}")
  expect(page).to have_content("enabled")
end





end
