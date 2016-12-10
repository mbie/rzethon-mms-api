Rails.application.routes.draw do
  resources :messages, only: [:create]
  resources :nodes, only: [:index]
  resources :submissions, only: [:create]
  resources :propagations, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
