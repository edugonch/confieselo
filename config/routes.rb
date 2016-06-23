Confieselo::Application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root :to => "confesions#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :confesions do
    resources :comments
    collection do
    	get 'author/:name', to: "confesions#author", as: "author"
    end
  end
  get '/search', to: 'confesions#search', as: 'search'
  resources :tags
  resources :ratings, only: :update
  get '/legal', to: 'home#legal'
  get '/terms', to: 'home#terms'
  get '/sitemap', to: 'home#sitemap'
  get '/robots.txt', to: 'home#robots'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
