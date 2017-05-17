Rails.application.routes.draw do

  get 'comment/new'

  resources :hotels, only: [:index, :new, :create, :show]
  resources :comments, only: [:create]

  root 'main#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
