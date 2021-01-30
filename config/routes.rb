Rails.application.routes.draw do
  root 'financial_products#index'

  get '/login', to: 'sessions#login'

  get '/auth/:provider/callback', to: 'sessions#create'

  post '/auth/:provider/callback', to: 'sessions#create'

  resources :sessions, only: [:create, :destroy] 

  resources :users, only: [:new, :create]

  resources :customers, controller: :users, only: [:edit, :show, :update, :destroy], type: 'Customer' do
    resources :user_accounts, only: [:index, :new, :create]
  end

  resources :admin, controller: :users, only: [:edit, :show, :update, :destroy]

  resources :user_accounts, only: [:show, :destroy] do
    resources :equities, controller: :positions, only: [:new, :create]
  end

  resources :equities, controller: :positions, type: 'Equity', only: [:show, :edit, :update, :destroy]

  resources :cash, controller: :positions, type: 'Cash', only: [:show, :edit, :update]

  resources :financial_products

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
