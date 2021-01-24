Rails.application.routes.draw do
  resources :menu_items
  resources :users
  get "/signin" => "sessions#new", as: :new_session
  post "/signin" => "sessions#create", as: :session
end
