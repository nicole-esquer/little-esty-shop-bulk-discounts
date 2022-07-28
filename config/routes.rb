Rails.application.routes.draw do
  
  get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  
  resources :merchants, except: [:show] do
    resources :items
    resources :invoices
    resources :customers
  end

  resources :items
  resources :invoices
  resources :transactions
  resources :invoice_items
  
  get "/admin/", to: "admin/dashboard#index", as: :admin_dashboard

  namespace :admin do
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index, :show]
  end
end
