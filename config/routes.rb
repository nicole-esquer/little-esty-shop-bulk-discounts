Rails.application.routes.draw do
  
  get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  
  resources :merchants, except: [:show] do
    resources :items
    resources :invoices
    resources :customers
  end
  
  resources :transactions
  resources :invoice_items
  get "/merchants/:id/items", to: "merchant_items#index"
  get "/merchants/:id/items/:id", to: "merchant_items#show"
  
  get "/admin/", to: "admin/dashboard#index", as: :admin_dashboard
  
  namespace :admin do
    resources :merchants, :invoices
  end

end


  