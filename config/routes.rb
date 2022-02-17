Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :auth do
        post '/login', to: 'login#login'
        post '/register', to: 'register#register'

        resource :profile, only: [:show, :update] do
          post :attach_avatar, on: :collection
        end
      end

      concern :likeable do
        post :like, on: :member
        delete :unlike, on: :member
      end

      resources :posts, shallow: true, concerns: :likeable do
        resources :comments, concerns: :likeable
      end

      resources :friend_requests, only: [:index, :create, :destroy] do
        put :approve, on: :member
      end

      resources :friendships, only: [:index, :destroy]

    end
  end
end
