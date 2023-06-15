
Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  
  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"

  get "/health_check", to: 'health_check#health_check', as: :rails_health_check
  resources :search_stats, only: [:index, :show]

  namespace :api do
    namespace :v1 do
      # User sign_up
      resources :users, only: :create
    end
  end
end
