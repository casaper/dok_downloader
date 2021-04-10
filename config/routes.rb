Rails.application.routes.draw do
  devise_for :users

  resources :target_dirs

  root to: 'target_dirs#index'
end
