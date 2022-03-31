Rails.application.routes.draw do
  resources :projects do
    resources :bugs
    resources :features
  end
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :users
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  devise_scope :user do
    get '/sign-in' => "devise/sessions#new", :as => :login
  end

  
end
