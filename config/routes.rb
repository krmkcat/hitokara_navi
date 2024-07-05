Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :admin do
    root 'dashboards#index'
    resources :users
    resources :shops
    resources :tags
    resources :areas
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    get 'prefectures/:prefecture_id/areas', to: 'prefecture_areas#index', as: :prefecture_areas
  end

  resources :password_resets, only: %i[create edit update]
  resource :password_resets, only: :new

  get 'prefectures/:prefecture_id/areas', to: 'areas#index', as: :prefecture_areas

  resources :shop_locations, only: :index

  resources :shops, only: %i[index show], shallow: true do
    resources :reviews
    resources :shop_tags, path: :tags, only: %i[index create destroy], as: :tags
    resources :favorites, only: :create
  end

  resources :favorites, only: %i[index destroy]

  post 'reviews/:review_id/nices', to: 'nices#create', as: :review_nices
  resources :nices, only: :destroy

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback' # for use with Github, Facebook
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  resources :users, only: :create do
    resource :profile, only: :show
  end
  resource :user, only: :destroy

  get 'users/:user_id/reviews', to: 'user_reviews#index', as: :user_reviews

  resource :profile, only: %i[edit update]

  get 'my_page', to: 'my_pages#index'

  resources :contacts, only: %i[new create]

  get 'privacy_policy', to: 'static_pages#privacy_policy'

  get 'signup', to: 'users#new'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  root 'static_pages#index'
end
