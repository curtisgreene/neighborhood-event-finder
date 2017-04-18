Rails.application.routes.draw do

  resources :users
  resources :events


  #sessions
  get '/login', to: 'sessions#new', as: :login
  post '/sessions', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  #appointments

  post '/appointments/:id', to: 'appointments#create'
  delete '/cancel', to: 'appointments#destroy', as: :cancel

  #search

  get '/search', to: 'events#search', as: :search
  post '/events', to: 'events#parse'

end
