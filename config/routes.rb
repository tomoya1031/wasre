Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root 'home#top'
  get 'about', to: 'home#about'
  resources :users, only: [:show, :edit, :update]
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  resources :orders, only: [:create, :index, :show]
  resources :products, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  get 'inquiry',to: 'inquiry#index'
  post 'inquiry/confirm',to: 'inquiry#confirm'
  post 'inquiry/thanks',to: 'inquiry#thanks' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end