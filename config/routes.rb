Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :destroy]
    member do
      post :like
    end
  end
  resources :users, only: [:create]
  root "posts#index"
end
