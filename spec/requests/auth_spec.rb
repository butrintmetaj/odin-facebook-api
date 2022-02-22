require 'rails_helper'

RSpec.describe 'Auth', type: :request do
  describe 'POST /register' do
    let(:user_params) { attributes_for(:user) }
    let(:user) { create(:user) }

    it 'generates a jwt when login is successful' do
      post '/api/v1/auth/register', params: user_params

      body = JSON.parse(response.body)

      expect(body.keys).to contain_exactly('data', 'token')

      expect(response).to have_http_status(:created)
    end
  end

  describe 'POST /login' do
    it 'generates a jwt when login is successful' do
      post '/api/v1/auth/login', params: { email: user.email, password: user.password }

      body = JSON.parse(response.body)

      expect(body.keys).to contain_exactly('data', 'token')

      expect(response).to have_http_status(:ok)
    end

    it ' Should return a status unauthorized when using wrong credentials' do

      post '/api/v1/auth/login', params: { email: user.email, password: rand(10..20) }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
