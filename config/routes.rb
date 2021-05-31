Rails.application.routes.draw do
  root to: 'tasks#index'
  
  get'signup',to: 'users#new'
  
  get 'users/index'
  get 'users/new'
  
  
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

 
 get 'login', to: 'sessions#new' 
 post 'login', to: 'sessions#create'
 delete 'logout', to: 'sessions#destroy'
 

 resources :users, only: [:index, :show, :create]
 
  resources :tasks
end
