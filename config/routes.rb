Rails.application.routes.draw do
  get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  resources :merchants, except: [:show]
  get "/merchants/:id/items", to: "merchants#items", as: :merchant_items
  resources :items
  resources :invoices
  resources :customers
  resources :transactions
  resources :invoice_items
  resources :item_merchants
  resources :merchant_invoice 
  
  get "/admin/", to: "admin/dashboard#index", as: :admin_dashboard
  
  namespace :admin do
    resources :merchants, :invoices
  end

end


  