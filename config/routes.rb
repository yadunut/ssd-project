Rails.application.routes.draw do
  resources :posts, only: %i[index create destroy]
  root 'posts#index'

  get 'users/search', to: 'users/users#search', as: :users_search

  get 'users/profile/:username', to: 'users/users#profile', as: :users_profile
  get 'users/profile', to: 'users/users#slashprofile'
  post 'users/profile', to: 'users/users#update', as: :update_users_profile

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get 'users/blocks', to: 'users/blocks#index', as: :block

  get 'users/blocks/new', to: 'users/blocks#new', as: :new_block
  post 'users/blocks', to: 'users/blocks#create', as: :create_block

  delete 'users/blocks/:id', to: 'users/blocks#destroy', as: :destroy_block
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
