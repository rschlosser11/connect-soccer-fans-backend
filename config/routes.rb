Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :teams, only: [:index, :show] do 
    resources :fixtures, only: [:index]
  end

  resources :fixtures, only: [:index, :show] do
    resources :comments, only: [:index]
  end

  post '/users/signin', to: 'users#signin'

  resources :users, only: [:create]
end
