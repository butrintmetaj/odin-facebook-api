class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.where.not(id: @current_user.friends_ids + [@current_user.id])

    render json: UserSerializer.new(@users).serializable_hash, status: :ok
  end

  def show
    render json: UserSerializer.new(@user).serializable_hash, status: :ok
  end

  private

  def set_user
    @user ||= User.find(params[:id])
  end
end
