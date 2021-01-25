Rails.application.routes.draw do
  root 'financial_products#index'

  get '/login', to: 'sessions#login'

  get '/auth/:provider/callback', to: 'sessions#create'

  post '/auth/:provider/callback', to: 'sessions#create'

  resources :sessions, only: [:create, :destroy]

  resources :customers, controller: :users, type: :Customer 

  resources :users do
    resources :user_accounts
  end

  resources :user_accounts, only: [:show] do
    resources :positions
  end

  resources :financial_products

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
