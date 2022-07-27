Rails.application.routes.draw do
  # get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  get "/merchants/:merchant_id/items/:id/edit", to: "merchant_items#edit"
  get "/merchants/:merchant_id/items", to: "merchant_items#index"
  patch "/merchants/:merchant_id/items/:id", to: "merchant_items#update"
  get "/merchants/:merchant_id/items/:id", to: "merchant_items#show"

  resources :merchants, except: [:show]

  get "/merchants/:id/items", to: "merchants#items", as: :merchant_items
  resources :items
  resources :invoices
  resources :customers
  resources :transactions
  resources :invoice_items
  resources :merchant_items
  resources :merchant_invoice 
  
  get "/admin/", to: "admin/dashboard#index", as: :admin_dashboard
  
  namespace :admin do
    resources :merchants, :invoices
  end

end
