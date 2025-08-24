Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    collection do
      get :my_posts
    end
  end
  resources :publishers

  # Authorization info page
  get "authorization", to: "authorization#index"
  patch "authorization/update_user_role", to: "authorization#update_user_role"

  # Admin routes
  namespace :admin do
    resources :users, only: [ :index, :show, :edit, :update, :destroy ]
    root "dashboard#index"
  end

  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
