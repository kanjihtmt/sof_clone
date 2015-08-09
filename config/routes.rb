Rails.application.routes.draw do
  root 'tops#index'

  resources :questions do
    resource :answers, except: %i(show) do
      post :preview, on: :collection
    end
    resource :comments, only: %i(new create)
    resource :votes, only: %i(new create)

    collection do
      get :search
      get :unanswered
      post :preview
      post :accept
    end
  end

  resources :answers, only: [] do
    resource :comments, only: %i(new create)
    resource :votes, only: %i(new create)
  end

  resources :tags, only: %i(index)

  namespace :mypage do
    resource :users, only: %i(show edit update)
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, only: %i(index show)
end
