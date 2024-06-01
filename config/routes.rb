Rails.application.routes.draw do
  root to: "welcome#index"
  get :users, to: "users#index"
  get :admin, to: "admin#index"

  namespace :apis do
    namespace :v1 do
      resources :movies, except: [:new, :edit]
      post :login, to: "sessions#create"
      post :register, to: "registrations#create"
      resources :tickets, only: [:create, :destroy] do
        collection do
          get :find_tickets_by_user
          get :find_tickets_by_date_time
        end
      end
    end
  end
end
