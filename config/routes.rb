# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_for :admins

  resources :posts, only: %i[index create destroy]

  # Only admins can do
  authenticated :admin do
    root 'admins/admins#index'
    get 'admins', to: 'admins/admins#index', as: :admin_root_path
    delete 'admins/user', to: 'admins/admins#destroy_user', \
                          as: :admin_destroy_user
  end

  # Only users can do
  authenticated :user do
    root 'posts#index'

    get 'users/blocks', to: 'users/blocks#index', as: :block
    get 'users/blocks/new', to: 'users/blocks#new', as: :new_block
    post 'users/blocks', to: 'users/blocks#create', as: :create_block
    delete 'users/blocks/:id', to: 'users/blocks#destroy', as: :destroy_block

    post 'users/profile', to: 'users/users#update', as: :update_users_profile
  end

  # Non signed in users
  devise_scope :user do
    root 'devise/sessions#new'
  end
  # Everyone
  get 'users/search', to: 'users/users#search', as: :users_search
  get 'users/profile/:username', to: 'users/users#profile', as: :users_profile
  get 'users/profile', to: 'users/users#slashprofile'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
