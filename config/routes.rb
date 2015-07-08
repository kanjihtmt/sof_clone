Rails.application.routes.draw do
  resources :questions
  root 'tops#index'
end
