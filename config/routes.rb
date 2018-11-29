Rails.application.routes.draw do

  root 'sessions#new'

  resources :users
  resources :maps
  resources :sessions, only: [:show, :edit, :new, :create, :destroy]
  resources :projects do
    resources :seats
  end
  resources :admin

  # @view/home/index.html.erb
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :assignments

  resources :employees

  #@view/admin/index.html.erb
  get 'show_map', to: 'maps#show', as: 'show_map'
  get 'create_map', to: 'maps#new', as: 'create_map'
  get 'edits_map', to: 'maps#edit', as: 'edits_map'
end
