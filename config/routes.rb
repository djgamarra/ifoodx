Rails.application.routes.draw do
  root 'application#index'
  scope :users do
    get 'signin', to: 'users#signin_view', as: :signin_view
    post 'signin', to: 'users#signin', as: :signin_api

    get 'signup', to: 'users#signup_view', as: :signup_view
    post 'signup', to: 'users#signup', as: :signup_api

    get 'account', to: 'users#account', as: :account
    post 'signout', to: 'users#signout', as: :signout
  end

  resources :orders, only: [:index, :show, :new, :create, :edit, :update]
end
