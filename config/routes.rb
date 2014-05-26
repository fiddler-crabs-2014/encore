Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  root to: "searches#index"

  get 'search', to: 'searches#search', as: 'search'
  get 'search_youtube', to: 'searches#search_youtube', as: 'search_youtube'

  resources :concerts, only: [:new, :create, :show]
  resources :venues, only: [:new, :create]
  resources :artists, only: [:new, :create]
  resources :songs, only: [:new, :create]

  post 'create_concert', to: 'concerts#create', as: 'create_concert'

  resources :users, only: [:index, :show]

  resources :attended_concerts, only: [:create]

end
