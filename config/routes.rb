Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get '/nodes/names', to: 'nodes#names'
  put '/nodes/register_name', to: 'nodes#register_name'
  get '/nodes/me', to: 'nodes#me'

  resources :messages, only: [:create, :index]
  resources :nodes, only: [:index, :show]
  resources :submissions, only: [:create]
  resources :propagations, only: [:create]
  resources :simulations, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
