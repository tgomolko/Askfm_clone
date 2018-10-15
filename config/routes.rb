Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :questions
  resources :relationships, only: [:create, :destroy]
  resources :users do 
    member do
      get :following, :followers
    end
    member do 
      get :feed
    end
  end
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root "users#index"
end
