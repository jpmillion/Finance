Rails.application.routes.draw do
  root 'financial_products#index'

  get '/login', to: 'sessions#login'

  
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]

  resources :sessions, only: [:create, :destroy] 

  resources :users, only: [:new, :create]

  resources :customers, except: [:new, :index] do
    resources :user_accounts, only: [:index, :new, :create]
  end

  resources :admins, except: [:new, :index] do
    get 'financial_stats', on: :collection
  end

  resources :user_accounts, only: [:show, :destroy], shallow: true  do
    resources :equities, controller: :positions, type: 'Equity'
  end

  resources :cash, controller: :positions, type: 'Cash', only: [:show, :edit, :update]

  resources :financial_products

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
