Rails.application.routes.draw do
  #get "/admin/merchants/:id", to: "admin/merchants#show"
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
  #get "/admin/merchants", to: "admin/merchants#index"
  #get "/admin/invoices", to: "admin/invoices#index"
  namespace :admin do
    resources :merchants#, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show]
  #get "/admin/merchants/:id/edit", to: "admin/merchants#edit"
  #get "/admin/merchants/:id", to: "admin/merchants#show"
  #patch "/admin/merchants/:id", to: "admin/merchants#update"
end
end
