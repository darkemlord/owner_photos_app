Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'sessions#new'
  delete '/logout', to: 'sessions#logout', as: 'logout'
  get '/oauth/callback', to: 'sessions#oauth_callback', as: 'oauth_callback'
  resources :sessions, only: %i[new create]
  resources :photos, only: %i[index new create]
  resources :photos do
    member do
      post 'tweet'
    end
  end
end
