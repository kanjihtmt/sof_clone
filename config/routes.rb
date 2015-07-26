Rails.application.routes.draw do
  root 'tops#index'
  resources :questions do
    collection do
      post :preview
    end
  end
  resources :tags, only: %i(index) do
    resources :questions
  end

  devise_for :users
end
