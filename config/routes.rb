Rails.application.routes.draw do
  resources :positions
  resources :user_accounts
  resources :financial_products
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
