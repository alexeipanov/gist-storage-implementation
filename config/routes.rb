Rails.application.routes.draw do
  root to: 'fragments#index'
  resources :fragments, only: [:index, :show, :new, :create]
end
