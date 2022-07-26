Rails.application.routes.draw do
  resources :transactions
  resources :items
  resources :merchant_invoices
  resources :invoice_items
  resources :invoices
  resources :merchants
  resources :customers
end
