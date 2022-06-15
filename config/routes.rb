Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  as :user do
    get 'users', :to => 'users#show', :as => :user_root # Rails 3
  end

end
