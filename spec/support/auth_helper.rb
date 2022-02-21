module AuthHelper
  def auth_with_user(user)
    post '/api/v1/auth/login', params: { email: user.email, password: user.password }
    token = JSON.parse(response.body)['token']
    { 'Authorization': "Bearer #{token}" }
  end

end