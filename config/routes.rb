Rails.application.routes.draw do
  root 'sessions#login'
  get '/login', to: 'sessions#login'
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', to: 'sessions#create'
  resources :sessions, only: [:create, :destroy]
  resources :stocks
  resources :watch_lists
  resources :transactions
  resources :positions
  resources :user_accounts
  resources :financial_products
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
