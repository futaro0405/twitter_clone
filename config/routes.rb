# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }

  resources :posts
  root to: 'home#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
