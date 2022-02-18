class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.where.not(id: @current_user.friends_ids + [@current_user.id])

    render json: UserSerializer.new(@users,{ params: { current_user_id: @current_user.id }}).serializable_hash, status: :ok
  end

  def show
    render json: UserSerializer.new(@user,{ params: { current_user_id: @current_user.id }}).serializable_hash, status: :ok
  end

  private

  def set_user
    @user ||= User.find(params[:id])
  end
end
