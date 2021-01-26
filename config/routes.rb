Rails.application.routes.draw do
  root 'financial_products#index'

  get '/login', to: 'sessions#login'

  get '/auth/:provider/callback', to: 'sessions#create'

  post '/auth/:provider/callback', to: 'sessions#create'

  resources :sessions, only: [:create, :destroy] 
  resources :users, only: [:new]
  resources :customers, controller: :users, type: :Customer do
    resources :user_accounts, only: [:index, :new, :create]
  end

  resources :user_accounts, only: [:show, :destroy], shallow: true do
    resources :equities, controller: :positions, type: :Equity
    resources :cash, controller: :positions, type: :Cash
  end

  resources :financial_products

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
