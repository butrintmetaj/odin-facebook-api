class Api::V1::Auth::ProfilesController < ApplicationController

  def show
    render json: UserSerializer.new(@current_user).serializable_hash, status: :ok
  end

  def update
    if @current_user.update(user_params)
      render json: UserSerializer.new(@current_user).serializable_hash, status: :ok
    else
      render json: { message: 'Could not update profile' }, status: :unprocessable_entity
    end
  end

  def attach_avatar
    if @current_user.avatar.attach(params[:avatar])
      render json: UserSerializer.new(@current_user).serializable_hash, status: :ok
    else
      render json: { message: 'Could not attach avatar' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :birthday, :gender)
  end
end
