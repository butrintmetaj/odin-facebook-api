class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.where.not(id: @current_user.friends_ids + [@current_user.id])
                 .includes(:friendships, :reverse_friendships, :posts)
                 .page(params[:page])
                 .per(params[:per_page])

    @users = UserSerializer.new(@users, { include: [:posts], params: { current_user_id: @current_user.id } })
                           .serializable_hash

    render json: @users.merge!(next_page: params[:page].to_i + 1), status: :ok
  end

  def show
    render json: UserSerializer.new(@user, { include: [:posts], params: { current_user_id: @current_user.id } }).serializable_hash, status: :ok
  end

  private

  def set_user
    @user ||= User.find(params[:id])
  end
end
