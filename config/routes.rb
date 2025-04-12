Rails.application.routes.draw do
  get "/assets/tailwindcss", to: redirect("/assets/tailwind")


  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root to: "pages#main"

  get "profile", to: "pages#profile", as: "profile"
  get "notifications", to: "notifications#index", as: "notifications"
  resources :venues do
    resources :reviews, only: [ :new, :create ]
    resources :questions, only: [ :new, :create ]
  end

  resources :questions, except: [ :new, :create ] do
    resources :answers, only: [ :new, :create ]
  end
  resources :answers, except: [ :new, :create ]
  resources :reviews, except: [ :new, :create ]

  get "up" => "rails/health#show", as: :rails_health_check
end
