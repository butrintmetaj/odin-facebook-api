class Api::V1::FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy]

  def index
    @friends = User.where(id: @current_user.friends_ids)

    render json: UserSerializer.new(@friends,{ params: { current_user_id: @current_user.id }}).serializable_hash, status: :ok
  end

  def destroy
    authorize(@friendship)

    if @friendship.destroy
      render json: { data: {}, message: 'Friendship removed' }, status: :ok
    else
      render json: { message: 'Could not delete friend' }, status: :unauthorized
    end
  end

  private

  def set_friendship
    @friendship ||= Friendship.find(params[:id])
  end
end
