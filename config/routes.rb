Rails.application.routes.draw do
  root 'merchants/dashboard#show'

  get "/merchants/:merchant_id/dashboard", to: "merchants/dashboard#show", as: :merchant_dashboard
  post "/merchants/:merchant_id/items/", to: "merchants/items#change_status"
  
  namespace :merchants do
    scope '/:id', only: [:show] do
      resources :items, only: [:index, :show, :edit, :update]
      resources :invoices, only: [:index, :show, :edit, :update]
    end
  end
  
  get "/admin/", to: "admin/dashboard#index", as: :admin_dashboard

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end