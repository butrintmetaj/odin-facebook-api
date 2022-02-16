class Api::V1::FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:approve, :destroy]
  before_action :set_requestee, only: [:create]

  def index
    @friend_requests = @current_user.received_friend_requests.status_pending

    render json: { data: @friend_requests}, status: :ok
  end

  def create
    @friend_request = @current_user.sent_friend_requests.new(requestee_id: @requestee.id)

    authorize @friend_request

    if @friend_request.save
      render json: { data: @friend_request }, status: :created
    else
      render error: { message: 'Could not create friend request' }
    end
  end

  def approve
    authorize @friend_request, :update?

    if @friend_request.update(status: FriendRequest.statuses[:accepted])
      render json: { data: @friend_request }, status: :ok
    else
      render json: { message: 'Could not update request status' }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @friend_request
    if @friend_request.destroy
      render json: { data: [], message: 'Request deleted successfully' }, status: :ok
    else
      render json: { message: 'Could not update delet status' }, status: :unprocessable_entity
    end
  end

  private

  def set_friend_request
    @friend_request ||= FriendRequest.find(params[:id])
  end

  private

  def set_requestee
    @requestee = User.find(params[:requestee_id])
  end

end
