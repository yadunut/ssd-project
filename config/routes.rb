# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  get 'posts', to: 'posts#index'
  post 'posts', to: 'posts#create'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
