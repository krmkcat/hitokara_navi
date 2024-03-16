Rails.application.routes.draw do
  resources :shop_tags, only: :destroy

  resources :shops, only: %i[index show] do
    resources :reviews, shallow: true
    get 'tags', to: 'shop_tags#edit'
    post 'tags', to: 'shop_tags#create'
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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
