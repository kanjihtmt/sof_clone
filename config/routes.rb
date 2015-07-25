Rails.application.routes.draw do
  root 'tops#index'
  resources :questions do
    collection do
      post :preview
    end
  end
  devise_for :users
end
