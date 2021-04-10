Rails.application.routes.draw do
  devise_for :users

  resources :arte_downloads
  resources :target_dirs

  root to: 'downloads#index'
end
