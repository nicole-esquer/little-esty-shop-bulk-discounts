Rails.application.routes.draw do
  get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  get "/merchants/:merchant_id/items", to: "merchants#items"
  resources :merchants, except: [:show]

end
