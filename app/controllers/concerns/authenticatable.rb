module Authenticatable
  def auth_header
    request.headers['Authorization']
  end

  def logged_in_user
    return nil unless (token = JwtService.decoded_token(auth_header))
    user_id = token[0]['user_id']
    @current_user = User.find_by(id: user_id)
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
