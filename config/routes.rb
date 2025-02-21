Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root to: "pages#main"

  resources :reviews, except: [ :new, :create ]

  resources :venues do
    resources :reviews, only: [ :new, :create ]
  end



  get "up" => "rails/health#show", as: :rails_health_check
end
