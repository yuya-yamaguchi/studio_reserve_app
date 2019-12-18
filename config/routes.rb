Rails.application.routes.draw do
  
  root 'top#index'

  resources :studios, only: [:show]

end
