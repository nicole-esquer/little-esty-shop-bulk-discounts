Rails.application.routes.draw do
  
  get "/merchants/:merchant_id/dashboard", to: "merchants/dashboard#show", as: :merchant_dashboard
  post "/merchants/:merchant_id/items/", to: "merchants/items#change_status"
  
  namespace :merchants do
    scope '/:id', only: [:show] do
      resources :items, only: [:index, :show, :edit, :update]
      resources :invoices, only: [:index, :show, :edit, :update]
    end
  end
  
  get "/admin/", to: "admin/dashboard#index", as: :admin_dashboard
  get "/admin/", to: "admin/dashboard#index", as: :admin_dashboard
  #get "/admin/merchants", to: "admin/merchants#index"
  #get "/admin/invoices", to: "admin/invoices#index"

  namespace :admin do
    resources :merchants#, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show]
  end
  #get "/admin/merchants/:id/edit", to: "admin/merchants#edit"
  #get "/admin/merchants/:id", to: "admin/merchants#show"
  #patch "/admin/merchants/:id", to: "admin/merchants#update"
end
