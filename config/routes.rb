# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
<<<<<<< HEAD
    sessions: 'customer/sessions',
    registrations: 'customer/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks',
=======
    sessions: 'users/sessions',
    registrations: 'users/registrations',
>>>>>>> feature/login
    confirmations: 'users/confirmations'
  }

  root to: 'home#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
