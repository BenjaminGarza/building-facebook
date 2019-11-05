Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: "posts#index"
  end
  devise_scope :user do
    root to: "users/sessions#new", as: "login_root"
  end

  get 'likes/:post_id', to: "posts#likes", as: 'likes'

  get 'profiles/:id', to: 'profiles#show', as: 'profiles'
  get 'add/:friend_id', to: "profiles#add", as: 'add'

  get 'cancel/:friend_id', to: "friends#cancel", as: 'cancel'
  get 'ignore/:friend_id', to: "friends#ignore", as: 'ignore'
  get 'remove/:friend_id', to: "friends#remove", as: 'remove'
  get 'accept/:friend_id', to: "friends#accept", as: 'accept'

  resources :posts
  resources :comments
  resources :likes
  resources :friends
end
