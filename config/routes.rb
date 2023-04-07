Rails.application.routes.draw do
  root to: "welcome#index"
  get :users, to: "users#index"

  namespace :apis do
    namespace :v1 do
      resources :movies, except: [:new, :edit]
      post :login, to: "sessions#create"
      post :register, to: "registrations#create"
    end
  end
end
