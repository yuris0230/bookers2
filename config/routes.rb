Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"

  get "users/info", to: "users#info", as: "user_info"

  resources :users, only: [:index, :show, :edit, :update]
  resources :books
end