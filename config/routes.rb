Rails.application.routes.draw do
  resources :users, only: %w(new create edit update show destroy) do
    member do
      get :following, :followers, :home, :collection
    end
  end
  resources :sessions, only: %w(new create destroy)
  resources :senryus, only: %w(new create destroy) do
    collection do
      get :discover
    end
    resources :favorites, only: %w(create destroy)
  end
  resources :relationships, only: %w(create destroy)
end
