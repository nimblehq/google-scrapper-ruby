
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  
  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  
  get "/health_check", to: 'health_check#health_check', as: :rails_health_check
  get "/search_stats", to: 'search_stats#index', as: :stats_stats_list
end
