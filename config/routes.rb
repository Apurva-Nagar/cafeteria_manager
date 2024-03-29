Rails.application.routes.draw do
  get "/", to: "home#index"
  resources :orders
  put "/cart_items/:id/decrease", to: "cart_items#decrease"
  put "/cart_items/:id/increase", to: "cart_items#increase"
  resources :cart
  resources :cart_items
  put "/menus/:id/details", to: "menus#update_details"
  resources :menus
  resources :menu_items
  resources :users
  get "/reports", to: "orders#get_report"
  post "/reports", to: "orders#show_report"
  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :session
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
