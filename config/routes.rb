Rails.application.routes.draw do
  root to: "welcome#index"

  namespace :apis do
    namespace :v1 do
      resources :movies, except: [:new, :edit]
    end
  end
end
