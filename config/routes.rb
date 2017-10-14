Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/adana/:name', to: 'application#adana'
  get '/konitiwa/:name', to: 'application#konitiwa'

  get '/users/', to: 'users#index'
  get '/users/new', to: 'users#new'
  get '/users/create', to: 'users#create'
  get '/users/:id/show', to: 'users#show'
  get '/users/:id/update', to: 'users#update'
  get '/users/:id/destroy', to: 'users#destroy'
end
