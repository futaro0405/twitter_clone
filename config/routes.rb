# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path_names: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: 'home#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
