# frozen_string_literal: true

Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }

  get 'users/profile' => "users#show"
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :posts
  root to: 'home#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
