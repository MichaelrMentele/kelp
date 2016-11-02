Rails.application.routes.draw do
  root to: 'businesses#index'

  get 'ui(/:action)', controller: 'ui' unless Rails.env.production?

  ### Sessions ###
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
  
  ### Users ###
  get '/register', to: "users#new"
  resources :users, only: [:create, :show]

  namespace :vendor do
    resources :businesses, only: [:new, :edit, :update, :create] do 
      resources :coupons, only: [:create, :edit, :update]
    end
  end

  resources :charges, only: [:create]

  resources :businesses, only: [:show, :index, :create, :new] do
    resources :reviews, only: [:create, :update]
  end
end
