class Api::V1::Auth::LoginController < ApplicationController
  skip_before_action :authorized, only: :login
  before_action :set_user, only: :login

  def login
    if @user&.authenticate(params[:password])
      token = JwtService.encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Credentials do not match our records' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def set_user
    @user ||= User.find_by_email(params[:email])
  end

end
