Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  resources :password_resets, only: %i[create edit update]
  resource :password_resets, only: :new

  get 'prefectures/:prefecture_id/areas', to: 'areas#index', as: :prefecture_areas

  resources :shops, only: %i[index show], shallow: true do
    resources :reviews
    resources :shop_tags, path: :tags, only: %i[index create destroy], as: :tags
  end

  get 'my_review', to: 'my_reviews#index'

  get 'mypage', to: 'profiles#show'
  resource :profile, only: %i[edit update]

  resources :users, only: :create
  get 'signup', to: 'users#new'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  root 'static_pages#index'
end
