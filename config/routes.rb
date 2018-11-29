Rails.application.routes.draw do

  root 'sessions#new'

  resources :users
  resources :maps
  resources :sessions, only: [:show, :edit, :new, :create, :destroy]
  resources :projects do
    resources :seats
  end

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :assignments
  
  resources :employees
end
