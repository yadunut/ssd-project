Rails.application.routes.draw do
  get 'users/search/:id', to: 'users/users#search'
  get 'users/profile/:username', to: 'users/users#profile'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
