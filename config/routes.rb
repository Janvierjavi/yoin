Rails.application.routes.draw do
  resources :users, only: %w(new create edit update show destroy)
  resources :sessions, only: %w(new create destroy)
  resources :senryus, only: %w(index new create destroy)
end
