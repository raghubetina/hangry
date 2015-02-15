Rails.application.routes.draw do
  resources :wait_times

  resources :restaurants

  devise_for :users

  root 'restaurants#index'
end
