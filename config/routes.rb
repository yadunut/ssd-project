# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  resources :blocks
  # get 'blocks', to: 'blocks#index'
  # get 'blocks/new', to: 'blocks#new'
  # post 'blocks', to: 'blocks#create'
  # get 'blocks/:id', to: 'blocks#show'

  get 'posts', to: 'posts#index'
  post 'posts', to: 'posts#create_post'

  post 'comments', to: 'posts#create_comment'

  get 'settings', to: 'users#settings'

  get 'search/:id', to: 'users#profile_search'
  # get '/:id/profile', to: 'users#profile' # Check profile_search.html.erb


  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
