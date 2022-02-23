require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:auth_header) { auth_with_token(user) }
  let!(:posts) { create_list(:post, 2, user_id: user.id) }
  let!(:comments) { create_list(:comment, 2, post_id: posts.first.id, user_id: user.id) }
  let!(:like) { create(:like, :comment, user_id: user.id) }

  describe 'GET /api/v1/posts/:post_id/comments' do
    it 'returns posts with its comments' do
      get "/api/v1/posts/#{posts.first.id}/comments", headers: auth_header

      body = JSON.parse(response.body)['data']
      expect(response).to have_http_status(:ok)
      expect(body['attributes']['id']).to eq(posts.first.id)
      expect( body['relationships']['comments']['data'].map { |cm| cm['id'].to_i}).to match_array(comments.map(&:id))

    end
  end

  describe 'POST /posts/:post_id/comments' do
    it 'creates a comment for a specfic post' do

      params = attributes_for(:comment)

      post "/api/v1/posts/#{posts.first.id}/comments", headers: auth_header, params: params

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['body']).to eq(params[:body])
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /comments/:id' do

    it 'returns post by id' do
      get "/api/v1/comments/#{comments.first.id}", headers: auth_header

      body = JSON.parse(response.body)['data']

      expect(body['attributes']['body']).to eq(comments.first.body)
      expect(body['relationships']['user']['data']['id'].to_i).to eq(comments.first.user_id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /comments/:id' do
    it 'updates authenticated users post' do

      params = { body: Faker::Lorem.sentence }

      put "/api/v1/comments/#{comments.first.id}", headers: auth_header, params: params

      body = JSON.parse(response.body)['data']

      expect(body['attributes']['body']).to eq(params[:body])
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /comments/:id' do
    it 'deletes authenticated users post' do

      expect { delete "/api/v1/comments/#{comments.first.id}", headers: auth_header }.to change { Comment.count }.by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /comments/:id/like' do
    it 'add a like for a specific post' do

      expect { post "/api/v1/comments/#{comments.first.id}/like", headers: auth_header }.to change { comments.first.likes_count }.by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /comments/:id/unlike' do
    it 'add a like for a specific post' do
      expect { delete "/api/v1/comments/#{like.likeable_id}/unlike", headers: auth_header }.to change { Like.count }.by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
