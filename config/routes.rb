Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, except: :create do
    member do
      get :followings, :followers
      resources :friendships, only: %i[create destroy] 
    end
  end
end
