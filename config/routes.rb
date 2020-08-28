# frozen_string_literal: true

Rails.application.routes.draw do
  # Routes for users
  resources :users, only: %i[new create]

  # Routes for properties
  resources :properties, only: %i[index show]
  get '/lastest', to: 'properties#lastest'

  # Routes for sessions
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  post 'signup', to: 'users#create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
