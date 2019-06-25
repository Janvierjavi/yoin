Rails.application.routes.draw do
  get 'yoin/top'
  root 'yoin#top'
  resources :users, only: %w(new create edit update show destroy) do
    member do
      get :following, :followers, :collection
    end
  end
  resources :sessions, only: %w(new create destroy)
  resources :senryus, only: %w(new create destroy) do
    collection do
      get :discover, :home
    end
    resources :favorites, only: %w(create destroy)
  end
  resources :relationships, only: %w(create destroy)
end
