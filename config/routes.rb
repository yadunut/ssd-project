# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  get 'posts', to: 'posts#index'
  post 'posts', to: 'posts#create_post'

  post 'comments', to: 'posts#create_comment'

  get 'settings', to: 'users#settings'

  get ':id', to: 'users#profile_search'
  get ':id/profile', to: 'users#profile'


  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
