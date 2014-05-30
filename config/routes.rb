Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  root to: "searches#index"

  post 'flag_video', to: 'concerts#flag_video', as: 'flag_video'
  post 'unflag_video', to: 'concerts#unflag_video', as: 'unflag_video'
  get 'search', to: 'searches#search', as: 'search'
  get 'search_youtube', to: 'searches#search_youtube', as: 'search_youtube'
  get 'search_setlist', to: 'searches#search_setlist', as: 'search_setlist'
  resources :concerts, only: [:new, :create, :show]
  resources :venues, only: [:new, :create]
  resources :artists, only: [:new, :create]
  resources :songs, only: [:new, :create]
  resources :concert_songs, only: [:create]

  post 'create_concert', to: 'concerts#create', as: 'create_concert'

  resources :users, only: [:index, :show]

  resources :attended_concerts, only: [:create]

  resources :relationships, only: [:create] do
    collection do
      post '/unfollow', to: "relationships#unfollow"
    end
  end

  resources :concert_photos, only: [:create, :destroy]

  resources :pages, only: [:index]
  get 'about', to: 'pages#index', as: 'about'

end
