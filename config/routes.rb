Rails.application.routes.draw do
  
  devise_for :users
  root 'top#index'

  resources :studios, only: [:show] do
    resources :reserves, only: [:show, :update]
  end

  resources :users, only: [:show, :edit, :update] do
    collection do
      get :reserve
    end
  end

  resources :user_reserves, only: [:index, :destroy]

end
