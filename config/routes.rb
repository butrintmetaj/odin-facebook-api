Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :auth do
        post '/login', to: 'login#login'
        post '/register', to: 'register#register'
      end

    end
  end
end
