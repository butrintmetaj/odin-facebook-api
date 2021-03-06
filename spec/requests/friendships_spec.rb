require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  let(:user) { create(:user) }
  let(:auth_header) { auth_with_token(user) }
  let!(:friendships) { create_list(:friendship, 2, user_id: user.id) }

  describe 'GET /friendships' do
    it 'returns a list of users that the current user is friends with' do
      get '/api/v1/friendships', headers: auth_header

      body = JSON.parse(response.body)['data']
      expect(response).to have_http_status(:ok)
      expect(body.map { |fr| fr['id'].to_i }).to match_array(friendships.map(&:friend_id))
      expect(body.size).to eq(friendships.size)
    end
  end

  describe 'DELETE /friendships/:id' do
    it 'deletes a current user friendship by a specific id' do

      expect { delete "/api/v1/friendships/#{friendships.first.id}", headers: auth_header }.to change { Friendship.count }.by(-1)
      expect(response).to have_http_status(:ok)

    end
  end
end
