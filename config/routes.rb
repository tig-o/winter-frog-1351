Rails.application.routes.draw do
  resources :plot_plants, only: [:destroy]
  resources :plots, only: [:index]
end
