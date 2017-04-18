Rails.application.routes.draw do

  resources :users
  resources :events, only: [:index]


  #sessions
  get '/login', to: 'sessions#new', as: :login
  post '/sessions', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  #appointments

  post '/appointments/:id', to: 'appointments#create'
  delete '/cancel', to: 'appointments#destroy', as: :cancel

  #search
  get '/events/nearby', to: 'events#nearby', as: :nearby_events
  get '/search', to: 'events#search', as: :search
  post '/events', to: 'events#results'
  get '/events/:id', to: 'events#show', as: :event

end
