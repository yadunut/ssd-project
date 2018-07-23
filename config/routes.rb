Rails.application.routes.draw do
  get 'users/search/:id', to: 'users/users#search', as: :users_search

  get 'users/profile/:username', to: 'users/users#profile', as: :users_profile
  get 'users/profile', to: 'users/users#slashprofile'
  post 'users/profile', to: 'users/users#update', as: :update_users_profile

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
