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

  resources :posts
  resources :comments
  resources :likes
end
