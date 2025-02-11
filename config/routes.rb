Rails.application.routes.draw do
  devise_for :users

  root to: "pages#main"


  resources :venues, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check

end
