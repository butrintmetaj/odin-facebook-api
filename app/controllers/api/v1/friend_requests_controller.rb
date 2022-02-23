class Api::V1::FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: [:approve, :destroy]
  before_action :set_requestee, only: [:create]
  before_action :set_pending_friend_requests, only: [:index, :count]

  def index
    @friend_requests = @pending_friend_requests.page(params[:page]).per(params[:per_page])

    @friend_requests = FriendRequestSerializer.new(@friend_requests).serializable_hash

    render json: @friend_requests.merge!(next_page: params[:page].to_i + 1) ,  status: :ok
  end

  def create
    @friend_request = @current_user.sent_friend_requests.new(requestee_id: @requestee.id)

    authorize @friend_request

    if @friend_request.save
      render json: FriendRequestSerializer.new(@friend_request).serializable_hash, status: :created
    else
      render error: { message: 'Could not create friend request' }
    end
  end

  def approve
    authorize @friend_request, :update?

    if @friend_request.update(status: FriendRequest.statuses[:accepted])
      render json: FriendRequestSerializer.new(@friend_request).serializable_hash, status: :ok
    else
      render json: { message: 'Could not update request status' }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @friend_request
    if @friend_request.destroy
      render json: { data: [], message: 'Request deleted successfully' }, status: :ok
    else
      render json: { message: 'Could not update delete status' }, status: :unprocessable_entity
    end
  end

  def count
    @pending_friend_requests = @pending_friend_requests.count

    render json: { pending_friend_requests: @pending_friend_requests }, status: :ok
  end

  private

  def set_pending_friend_requests
    @pending_friend_requests = @current_user.received_friend_requests.status_pending.includes(:requester, :requestee)
  end

  private

  def set_friend_request
    @friend_request ||= FriendRequest.find(params[:id])
  end

  private

  def set_requestee
    @requestee ||= User.find(params[:requestee_id])
  end

end
