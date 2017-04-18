Rails.application.routes.draw do

  resources :users
  resources :events

  get '/login', to: 'sessions#new', as: :login
  post '/sessions', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout
  post '/appointments/:id', to: 'appointments#create'
end
