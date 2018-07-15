# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/profile'
  get 'users/settings'
  root 'posts#index'

  get 'posts', to: 'posts#index'
  post 'posts', to: 'posts#create_post'

  post 'comments', to: 'posts#create_comment'

  get 'profile', to: 'users#profile'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
