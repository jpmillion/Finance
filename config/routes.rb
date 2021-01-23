Rails.application.routes.draw do
  root 'financial_products#index'
  get '/login', to: 'sessions#login'
  get '/auth/:provider/callback', to: 'sessions#create'
  post '/auth/:provider/callback', to: 'sessions#create'
  resources :sessions, only: [:create, :destroy]
  resources :transactions
  resources :positions
  resources :financial_products
  resources :users do
    resources :user_accounts
    resources :watch_lists
    resources :stocks
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
