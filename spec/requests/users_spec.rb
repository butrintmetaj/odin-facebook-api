require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }
  let!(:users) { create_list(:user, 2) }
  let(:auth_header) { auth_with_token(user) }

  describe 'GET /users' do
    it 'returns a list of users that current user is not friends' do
      get '/api/v1/users', headers: auth_header

      body = JSON.parse(response.body)['data']

      expect(response).to have_http_status(:ok)
      expect(body.size).to eq(users.size)
    end

    describe 'GET /users/:id' do
      it 'returns a list of users that current user is not friends' do
        get "/api/v1/users/#{users.first.id}", headers: auth_header

        body = JSON.parse(response.body)['data']

        expect(response).to have_http_status(:ok)
        expect(body['attributes']['id']).to eq(users.first.id)
        expect(body['attributes']['email']).to eq(users.first.email)
      end
    end
  end
end
