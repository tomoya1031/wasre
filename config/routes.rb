Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  devise_for :users, controllers: { 
    omniauth_callbacks: 'omniauth_callbacks',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }#, skip: :all
  # devise_scope :user do
  #   get 'login' => 'devise/sessions#new', as: :new_user_session
  #   post 'login' => 'devise/sessions#create', as: :user_session
  #   delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  #   get 'singin' => 'devise/registrations#new', as: :new_user_registration
  #   post 'singin' => 'devise/registrations#create', as: :user_registration
  #   match 'users/auth/google_oauth2',to: 'devise/omniauth_callbacks#passthru', as: :user_google_oauth2_omniauth_authorize, via: [:get, :post]
  #   match 'users/auth/google_oauth2/callback',to: 'devise/omniauth_callbacks#google_oauth2', as: :user_google_oauth2_omniauth_callback, via: [:get, :post]
  # end
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'home#top'
  get 'about', to: 'home#about'
  resources :users, only: [:show, :edit, :update]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :orders, only: [:create, :index, :show]
  resources :notifications, only: [:index, :destroy]
  
  resources :products, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  get 'inquiry',to: 'inquiry#index'
  post 'inquiry/confirm',to: 'inquiry#confirm'
  get 'inquiry/confirm', to:'inquiry#index'
  post 'inquiry/thanks',to: 'inquiry#thanks' 
  get 'inquiry/thanks', to:'inquiry#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end