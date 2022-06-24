Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
<<<<<<< HEAD
  resources :users, except: :create do
    member do
      get :followings, :followers
      resources :friendships, only: %i[create destroy] 
    end
  end
=======
  resources :users, only: %i(index show)
  resources :users do
    member do
      get :followings, :followers
    end
  end
  resources :friendships, only: [:create, :destroy]
>>>>>>> b720128b931a4830fb30f9570a6cc5b560fbf521
end
