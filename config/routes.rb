require 'sidekiq/web'

Rails.application.routes.draw do

  get 'sessions/create'
  resources :friendships
  resources :groups
  resources :posts
  #resources :tweets
  
  # get '/auth/:provider/callback', to: 'session#create'
  # root to: "tweets#index"

  namespace :admin do
      resources :users 
      resources :notifications
      resources :announcements
      resources :services
      root to: "users#index"
    end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
