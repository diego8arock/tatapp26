Rails.application.routes.draw do

  get 'reports/assignments'
  root 'home#index'

  devise_for :users
  resources :maps
  resources :sessions, only: [:edit]
  resources :projects do
    post 'image', :on => :member
    post 'zoneimage', :on => :member
  end

  resources :seats
  resources :admin
  resources :assignments
  resources :employees
  resources :seats
  resources :zones

  # @view/home/index.html.erb
  # get 'signup', to: 'users#new', as: 'signup'
  # get 'login', to: 'sessions#new', as: 'login'
  # get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'confirmation', to: 'sessions#confirmation', as: 'confirmation'

  #@view/admin/index.html.erb
  get 'showmap', to: 'maps#show', as: 'showmap'
  get 'createmap', to: 'maps#new', as: 'createmap'
  get 'editmap', to: 'maps#edit', as: 'editmap'
  get 'showprojects', to: 'projects#index', as: 'showprojects'
  get 'showproject', to: 'projects#show', as: 'showproject'
  get 'createproject', to: 'projects#new', as: 'createproject'
  get 'editproject', to: 'projects#edit', as: 'editproject'
  get 'zoneproject', to: 'projects#zone', as: 'zoneproject'
  get 'markseats', to: 'seats#new', as: 'markseats'
  get 'assignseats', to: 'seats#assign', as: 'assignseats'

  match "/assignment/:id/cancel" => "assignments#cancel", :via => :post
  get 'generalmap', to: 'assignments#image', as: 'generalmap'
  devise_scope :user do match '/sessions/user', to: 'devise/sessions#create', via: :post end

  get 'loademployees', to: 'employees#load', as: 'loademployees'
  post 'save_loademployees', to: 'employees#save_load', as: 'save_loademployees'

# Download template csv
  get 'download_csv', to: 'employees#download_csv', as: 'download_csv'
end
