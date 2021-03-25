Rails.application.routes.draw do
  resources :tasks
  root 'tasks#index'
  resources :users, only: [:new, :create, :show]

end
