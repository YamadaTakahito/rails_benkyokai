Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/adana/:name', to: 'application#adana'
  get '/konitiwa/:name', to: 'application#konitiwa'

end
