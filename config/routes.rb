Rails.application.routes.draw do
  
  devise_for :users
  root 'top#index'

  resources :studios, only: [:show] do
    resources :reserves, only: [:show, :update]
  end

  resources :users, only: [:show, :edit, :update] do
    resources :chatrooms, only: [:index] do
      collection do
        get :room_judge
      end
    end
    
    collection do
      get :reserve
    end
  end

  resources :user_reserves, only: [:index, :destroy]

  resources :posts

  resources :chatrooms, only: [:show] do
    resources :messages, only: [:create]
  end

  resources :sessions, only: [:index, :show, :new, :create] do
    resources :entry_musics, only: [:create] do
      resources :entry_parts, only: [:update] do
        member do
          get 'cancel'
        end
      end
    end

    collection do
      post :confirm
    end
  end
end
