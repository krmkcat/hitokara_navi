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

  get 'shop_locations', to: 'shop_locations#index'

  resources :shops, only: %i[index show], shallow: true do
    resources :reviews
    resources :shop_tags, path: :tags, only: %i[index create destroy], as: :tags
    resources :favorites, only: :create
  end

  resources :favorites, only: %i[index destroy]

  get 'my_review', to: 'my_reviews#index'

  get 'mypage', to: 'profiles#show'
  resource :profile, only: %i[edit update]

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback' # for use with Github, Facebook
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  resources :users, only: :create
  resource :user, only: :destroy
  get 'signup', to: 'users#new'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  root 'static_pages#index'
end
