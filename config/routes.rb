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

  resources :businesses, only: [:show, :index, :create, :new] do
    resources :reviews, only: [:create, :update]
  end
end
