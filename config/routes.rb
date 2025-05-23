Rails.application.routes.draw do
  get "/assets/tailwindcss", to: redirect("/assets/tailwind")

  namespace :admin do
    resources :panel, only: [ :index ]
    resources :venues, only: [ :destroy ]
    resources :venue_types, only: [ :new, :create, :destroy, :edit, :update ]
    resources :reviews, only: [ :destroy, :edit, :update ]
  end

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root to: "pages#main"

  get "profile", to: "pages#profile", as: "profile"

  # notifications

  resources :notifications, only: [ :index, :destroy ] do
    member do
      patch :mark_as_read
    end
  end


  resources :venues do
    resources :reviews, only: [ :new, :create ]
    resources :questions, only: [ :new, :create ]
  end

  resources :questions, except: [ :new, :create ] do
    resources :answers, only: [ :new, :create ]
  end
  resources :answers, except: [ :new, :create ]
  resources :reviews, except: [ :new, :create ]

  resources :venue_types, only: [ :index ]

  get "up" => "rails/health#show", as: :rails_health_check
end
