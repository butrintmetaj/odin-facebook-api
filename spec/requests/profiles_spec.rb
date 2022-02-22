require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let(:user) { create(:user) }
  let(:auth_header) { auth_with_token(user) }

  describe 'GET /profile' do
    it 'returns authenticated users profile information' do

      get '/api/v1/auth/profile', headers: auth_header
      body = JSON.parse(response.body)['data']

      expect(response).to have_http_status(:ok)
      expect(body['attributes']['id']).to eq(user.id)
      expect(body['attributes']['email']).to eq(user.email)
    end
  end

  describe 'PUT /profile' do
    it 'updates authenticated users profile information' do

      params = { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }

      put '/api/v1/auth/profile', headers: auth_header, params: params

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['first_name']).to eq(params[:first_name])
      expect(body['attributes']['last_name']).to eq(params[:last_name])
      expect(response).to have_http_status(:ok)
    end
  end
end
