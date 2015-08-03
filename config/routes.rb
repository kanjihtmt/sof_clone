Rails.application.routes.draw do
  root 'tops#index'

  resources :questions do
    resource :answers, except: %i(show) do
      collection do
        post :preview
      end
    end
    resource :comments, only: %i(new create)
    resource :votes, only: %i(new create)

    collection do
      post :preview
    end
  end

  resources :answers, only: [] do
    resource :comments, only: %i(new create)
    resource :votes, only: %i(new create)
  end

  resources :tags, only: %i(index) do
    resources :questions
  end

  devise_for :users, controllers: { registrations: 'registrations' }
end
