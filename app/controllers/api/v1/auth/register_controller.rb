class Api::V1::Auth::RegisterController < ApplicationController
  skip_before_action :authorized

  def register
    @user = User.new(user_params)

    if @user.save
      token = JwtService.encode_token({ user_id: @user.id })
      render json: (UserSerializer.new(@user).serializable_hash).merge!(token: token), status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :birthday, :gender)
  end

end
