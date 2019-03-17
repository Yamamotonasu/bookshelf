Rails.application.routes.draw do
  resources :reviews
  devise_for :users
  resources :books do
    resources :reviews, except: :index
  end
  root 'books#index'
end
