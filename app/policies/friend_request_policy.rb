class FriendRequestPolicy < ApplicationPolicy
  attr_reader :user, :friend_request

  def initialize(user, friend_request)
    @user = user
    @friend_request = friend_request
  end

  def create?
    !FriendRequest.where(requester_id: user.id, requestee_id:friend_request.requestee_id).or(FriendRequest.where(requester_id: friend_request.requestee_id, requestee_id: user.id)).exists?
  end


  def update?
    user.id == friend_request.requestee_id && friend_request.status == 'pending'
  end

  def destroy?
    user.id == friend_request.requestee_id || user.id == friend_request.requester_id
  end
end
