Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :auth do
        post '/login', to: 'login#login'
        post '/register', to: 'register#register'
        resource :profile, only: [:show, :update]
      end
    end
  end
end
