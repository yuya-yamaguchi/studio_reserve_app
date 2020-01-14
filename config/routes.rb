Rails.application.routes.draw do
  
  ActiveAdmin.routes(self)
  devise_for :users
  root 'top#index'

  resources :studios, only: [:show] do
    resources :reserves, only: [:show, :update] do
      collection do
        get :duplicate
      end
    end
  end

  resources :users, only: [:show, :edit, :update] do
    resources :chatrooms, only: [:index] do
      collection do
        get :room_judge
      end
    end
    
    collection do
      get :reserve
      get :notice
    end
  end

  resources :user_reserves, only: [:index, :destroy]

  resources :posts do
    collection do
      get :search
    end
  end

  resources :chatrooms, only: [:show] do
    resources :messages, only: [:create]
  end

  resources :sessions, as: :music_sessions do
    resources :entry_sessions, only: [:create, :destroy]

    resources :entry_musics, only: [:create, :show, :edit, :update, :destroy] do
      resources :entry_parts, only: [:update] do
        member do
          get 'cancel'
        end
      end
    end

    collection do
      post :confirm
      get  :search
    end
  end
end
