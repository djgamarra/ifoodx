Rails.application.routes.draw do
  root 'application#index'
  resources :users, only: %i[new create edit update]
  scope :users do
    post 'signin', controller: :users, as: :signin
    get 'login', controller: :users, as: :login
    get 'account', controller: :users, as: :account
  end
end
