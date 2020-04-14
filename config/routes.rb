Rails.application.routes.draw do
  root 'application#index'
  scope :users do
    get 'signin', to: 'users#signin_view', as: :signin_view
    post 'signin', to: 'users#signin', as: :signin_api

    get 'signup', to: 'users#signup_view', as: :signup_view
    post 'signup', to: 'users#signup', as: :signup_api

    get 'account', controller: :users, as: :account
  end
end
