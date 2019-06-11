Rails.application.routes.draw do
  resources :senryus, only: %w(index new create destroy)
end
