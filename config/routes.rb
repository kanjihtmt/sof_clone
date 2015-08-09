Rails.application.routes.draw do
  root 'tops#index'

  resources :questions do
    resource :answers, except: %i(show) do
      post :preview, on: :collection
    end
    resource :comments, only: %i(new create)
    resource :votes, only: %i(new create)

    post :preview, on: :collection
    post :accept, on: :member
  end

  resources :answers, only: [] do
    resource :comments, only: %i(new create)
    resource :votes, only: %i(new create)
  end

  resources :tags, only: %i(index) do
    resources :questions
  end

  namespace :mypage do
    resource :users, except: %i(index create new) do
      member do
        get :profile
        get :questions
        get :answers
      end
    end
  end

  devise_for :users, controllers: { registrations: 'registrations' }
end
