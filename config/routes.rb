Rails.application.routes.draw do
  root 'application#index'
  mount ActionCable.server => "/cable"
  scope :users do
    get 'signin', to: 'users#signin_view', as: :signin_view
    post 'signin', to: 'users#signin', as: :signin_api

    get 'signup', to: 'users#signup_view', as: :signup_view
    post 'signup', to: 'users#signup', as: :signup_api

    get 'account', to: 'users#account', as: :account
    post 'signout', to: 'users#signout', as: :signout
  end

  post 'orders/send_message', to: 'orders#send_message', as: :send_message
  resources :orders, only: [:index, :show, :new, :create, :edit, :update]
end
