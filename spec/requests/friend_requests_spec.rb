require 'rails_helper'

RSpec.describe 'FriendRequests', type: :request do
  let(:user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:auth_header) { auth_with_token(user) }
  let!(:friend_request) { create(:friend_request, requestee_id: user.id) }
  let!(:friend_requests) { create_list(:friend_request, 2, requestee_id: user.id) }

  describe 'GET /friend_requests' do
    it 'returns current users pending friend requests' do
      get '/api/v1/friend_requests', headers: auth_header

      body = JSON.parse(response.body)['data']

      expect(response).to have_http_status(:ok)
      expect(body[0]['attributes']['id'].to_i).to eq(friend_request.id)
      expect(body[0]['attributes']['status']).to eq(friend_request.status)
      expect(body[0]['relationships']['requester']['data']['id'].to_i).to eq(friend_request.requester_id)
      expect(body[0]['relationships']['requestee']['data']['id'].to_i).to eq(user.id)
    end
  end

  describe 'POST /friend_requests' do
    it 'creates a friend request by the authenticated user' do

      post '/api/v1/friend_requests', headers: auth_header, params: { requestee_id: second_user.id }

      body = JSON.parse(response.body)['data']

      expect(body['attributes']['status']).to eq('pending')
      expect(body['relationships']['requester']['data']['id'].to_i).to eq(user.id)
      expect(body['relationships']['requestee']['data']['id'].to_i).to eq(second_user.id)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /friend_requests/:id/approve' do
    it 'updates friend request status from pending to accepted by requestee' do

      put "/api/v1/friend_requests/#{friend_request.id}/approve", headers: auth_header

      body = JSON.parse(response.body)['data']

      expect(body['attributes']['status']).to eq('accepted')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /friend_requests/:id/approve' do
    it 'deletes a friend request that can be deleted by requester or requestee users' do

      expect { delete "/api/v1/friend_requests/#{friend_request.id}", headers: auth_header }.to change { FriendRequest.count }.by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /friend_requests/count' do
    it 'returns count of pending friend requests' do

      get '/api/v1/friend_requests/count', headers: auth_header

      body = JSON.parse(response.body)
      expect(body['pending_friend_requests']).to eq(friend_requests.size + [friend_request].size)
      expect(response).to have_http_status(:ok)
    end
  end
end
