Rails.application.routes.draw do
  resources :users
  resources :senryus, only: %w(index new create destroy)
end
