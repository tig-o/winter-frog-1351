Rails.application.routes.draw do
  resources :plots, only: [:index]
end
