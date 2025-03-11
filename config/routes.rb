Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root to: "pages#main"

  get "profile", to: "pages#profile", as: "profile"

  resources :venues do
    resources :reviews, only: [ :new, :create ]
  end

  resources :reviews, except: [ :new, :create ]

  get "up" => "rails/health#show", as: :rails_health_check
end
