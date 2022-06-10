Rails.application.routes.draw do
  devise_for :users
  resources :books
   #:letter_opener_webの設定にあたり追加
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
