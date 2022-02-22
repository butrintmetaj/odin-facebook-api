require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let(:auth_header) { auth_with_token(user) }
  let!(:posts) { create_list(:post, 2, user_id: user.id) }
  let(:like) { create(:like)}

  describe 'GET /posts' do
    it 'returns current users posts and they friends posts ordered by created_at in descending order' do
      get '/api/v1/posts', headers: auth_header

      body = JSON.parse(response.body)['data']

      expect(response).to have_http_status(:ok)
      expect(body.size).to eq(posts.size)
    end
  end

  describe 'POST /posts' do
    it 'creates a post by the authenticated user' do

      params = attributes_for(:post)

      post '/api/v1/posts', headers: auth_header, params: params

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['body']).to eq(params[:body])
      expect(body['relationships']['user']['data']['id'].to_i).to eq(user.id)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /posts/:id' do

    it 'returns post by id' do
      get "/api/v1/posts/#{posts.first.id}", headers: auth_header

      body = JSON.parse(response.body)['data']

      expect(body['attributes']['body']).to eq(posts.first.body)
      expect(body['relationships']['user']['data']['id'].to_i).to eq(posts.first.user_id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /posts/:id' do
    it 'updates authenticated users post' do

      params = { body: Faker::Lorem.sentence }

      put "/api/v1/posts/#{posts.first.id}", headers: auth_header, params: params

      body = JSON.parse(response.body)['data']

      expect(body['attributes']['body']).to eq(params[:body])
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /posts/:id' do
    it 'deletes authenticated users post' do

      expect { delete "/api/v1/posts/#{posts.first.id}", headers: auth_header }.to change { Post.count }.by(-1)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /posts/:id/like' do
    it 'add a like for a specific post' do

      expect { post "/api/v1/posts/#{posts.first.id}/like", headers: auth_header }.to change { posts.first.likes_count }.by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /posts/:id/unlike' do
    it 'add a like for a specific post' do

      expect { delete "/api/v1/posts/#{like.likeable_id}/unlike", headers: auth_header }.to change { Likes.count }.by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
