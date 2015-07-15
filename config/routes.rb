Rails.application.routes.draw do
  root 'tops#index'
  resources :questions
  devise_for :users
end
