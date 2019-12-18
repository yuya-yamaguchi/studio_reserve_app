Rails.application.routes.draw do
  
  devise_for :users
  root 'top#index'

  resources :studios, only: [:show] do
    resources :reserves, only: [:show, :update]
  end
end
