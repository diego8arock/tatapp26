Rails.application.routes.draw do

  root 'sessions#new'

  resources :users
  resources :maps
  resources :sessions, only: [:show, :edit, :new, :create, :destroy]
  resources :projects
  resources :admin
  resources :assignments
  resources :employees
  resources :seats

  # @view/home/index.html.erb
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  #@view/admin/index.html.erb
  get 'showmap', to: 'maps#show', as: 'showmap'
  get 'createmap', to: 'maps#new', as: 'createmap'
  get 'editmap', to: 'maps#edit', as: 'editmap'
  get 'showproject', to: 'projects#show', as: 'showproject'
  get 'createproject', to: 'projects#new', as: 'createproject'
  get 'editproject', to: 'projects#edit', as: 'editproject'
  get 'markseats', to: 'seats#new', as: 'markseats'

  match "/assignment/:id/cancel" => "assignments#cancel", :via => :post

end
