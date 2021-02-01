Rails.application.routes.draw do
  root 'financial_products#index'

  get '/login', to: 'sessions#login'

  get '/auth/:provider/callback', to: 'sessions#create'

  post '/auth/:provider/callback', to: 'sessions#create'

  resources :sessions, only: [:create, :destroy] 

  resources :users, only: [:new, :create]

  resources :customers, controller: :users, type: 'Customer', except: [:new] do
    resources :user_accounts, only: [:index, :new, :create]
  end

  resources :admins, controller: :users, type: 'Admin', except: [:new] do
    get 'financial_stats', on: :collection
  end

  resources :user_accounts, only: [:show, :destroy], shallow: true  do
    resources :equities, controller: :positions, type: 'Equity' only: [:index, :new, :create]
  end

  resources :cash, controller: :positions, type: 'Cash', only: [:show, :edit, :update]

  resources :financial_products

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
