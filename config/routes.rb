Rails.application.routes.draw do
  root 'tops#index'

  resources :questions, except: %i(destroy) do
    resources :answers, except: %i(show new) do
      post :preview, on: :collection
    end
    resource :comments, only: %i(new create)
    resource :votes, only: %i(create)

    collection do
      get :search
      get :unanswered
      post :preview
    end

    post :accept, on: :member
  end

  resources :answers, only: [] do
    resource :comments, only: %i(new create)
    resource :votes, only: %i(create)
  end

  resources :tags, only: %i(index)

  namespace :mypage do
    resource :users, only: %i(show edit update)
  end

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, only: %i(index show)
end
