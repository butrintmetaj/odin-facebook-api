class Friendship < ApplicationRecord
  after_commit :remove_friend_request, on: :destroy
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def remove_friend_request
    FriendRequest.where(requester_id: user_id, requestee_id: friend_id)
                 .or(FriendRequest.where(requester_id: friend_id, requestee_id: user_id)).destroy_all
  end

end
