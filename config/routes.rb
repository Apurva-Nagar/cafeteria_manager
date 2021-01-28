Rails.application.routes.draw do
  get "/", to: "home#index"
  resources :orders
  resources :menus
  resources :menu_items
  put "/menus/:id/details", to: "menus#updateDetails"
  resources :users
  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :session
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
