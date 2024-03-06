Rails.application.routes.draw do
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
