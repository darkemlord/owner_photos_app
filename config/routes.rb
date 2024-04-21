Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'sessions#new'
  delete 'logout', to: 'sessions#logout', as: 'logout'
  resources :sessions, only: %i[new create]
  resources :photos, only: %i[index new create]
end
