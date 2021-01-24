Rails.application.routes.draw do
  resources :menu_items
  resources :users
  post "/signin" => "sessions#create", as: :session
end
