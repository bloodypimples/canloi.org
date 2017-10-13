Rails.application.routes.draw do
  get 'admin', to: "static_pages#cms"

  resources :comments

  devise_for :users
  resources :users
  resources :posts do
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
    resources :comments
  end
  root 'posts#index'
end
