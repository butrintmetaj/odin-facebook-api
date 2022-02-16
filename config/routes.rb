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

      resources :posts
      resources :friend_requests, only: [:index, :create, :destroy] do
        put :approve, on: :member
      end
    end
  end
end
