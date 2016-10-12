Rails.application.routes.draw do
  root to: 'ui#index'

  get 'ui(/:action)', controller: 'ui'

  get '/login', to: "sessions#new"
  post '/logout', to: "sessions#destroy"
  
  resources :users, except: [:destroy]

  resources :businesses, only: [:show, :index, :create, :new] do
    resources :reviews, only: [:create, :update]
  end
end
