Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  authenticated :user do
    root to: "posts#index"
  end
  devise_scope :user do
    root to: "users/sessions#new", as: "login_root"
  end

  get 'likes/:post_id', to: "posts#likes", as: 'likes'

  get 'profiles/:id', to: 'profiles#show', as: 'profiles'
  get 'profiles/:id/all', to: 'profiles#index', as: 'find_friends'
  get 'profiles/:id/friends', to: 'profiles#friends', as: 'friends'
  get 'profiles/:id/requests', to: 'profiles#requests', as: 'requests'
  get 'profiles/:id/posts', to: 'profiles#posts', as: 'user_posts'
  get 'add/:friend_id', to: "friends#add", as: 'add'

  get 'cancel/:friend_id', to: "friends#cancel", as: 'cancel'
  get 'ignore/:friend_id', to: "friends#ignore", as: 'ignore'
  get 'remove/:friend_id', to: "friends#remove", as: 'remove'
  get 'accept/:friend_id', to: "friends#accept", as: 'accept'

  post '/notify', to: "friends#notify", as: 'notify'

  resources :posts
  resources :comments
  resources :likes
  resources :friends
end
