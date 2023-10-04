# Rails.application.routes.draw do
#   get 'home/index'
#   get 'profiles/show'
#   devise_for :users
#   get 'profile', to: 'profiles#show', as: 'profile'
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
#   mount ActionCable.server => '/cable'

#   require 'sidekiq/web'
#   mount Sidekiq::Web => '/sidekiq'

#   # Defines the root path route ("/")
#   # root "articles#index"
#   root to: "home#index"
# end

Rails.application.routes.draw do
  # Devise routes with custom controllers
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
    # ... add other controllers if you plan to customize them
  }

  # Profiles
  get 'profiles/show'
  get 'profile', to: 'profiles#show', as: 'profile'

  # Home
  get 'home/index'
  root to: "home#index"

  # ActionCable
  mount ActionCable.server => '/cable'
  
  #logout
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # Sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
