Rails.application.routes.draw do
  get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  resources :merchants, except: [:show]

  get "/admin/", to: "admin/dashboard#index", as: :admin_dashboard
  
  namespace :admin do
    resources :merchants, :invoices
  end
end


  