# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: %i[show] do
    resource :relationships, only: %i[create destroy]
    member do
      get :followings, :followers
    end
  end

  resources :posts do
    resources :comments, only: %i[create]
    resource :reposts, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
    resource :bookmarks, only: %i[create destroy]
  end

  resources :bookmarks, only: %i[index]

  root to: 'home#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
