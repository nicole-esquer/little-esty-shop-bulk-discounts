Rails.application.routes.draw do
  get "/merchants/:id/dashboard", to: "merchants#show", as: :merchant_dashboard
  resources :merchants, except: [:show]

end
