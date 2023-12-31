Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "pages#dashboard"
  resources :pacts, except: [:destroy, :update]
  resources :challenges, only: :index
  get "/account", to: "pages#account"

  post "/pacts/:id/join", to: "pacts#join", as: "join_challenge"
  patch "/pacts/:id/", to: "pacts#update", as: "update_pact"

  get "/strava_token", to: "pages#strava_token"

  get "/avatar/:id", to: "avatar#show", as: "avatar"
  patch "/avatar/:id", to: "avatar#update", as: "avatar_update"
end
