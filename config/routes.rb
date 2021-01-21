Rails.application.routes.draw do
  get 'sessions/login', to: 'sessions#login'
  resources :stocks
  resources :watch_lists
  resources :transactions
  resources :positions
  resources :user_accounts
  resources :financial_products
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
