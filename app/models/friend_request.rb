class FriendRequest < ApplicationRecord
  after_commit :create_friendship, on: :update

  enum status: {
    pending: 0,
    accepted: 1
  },_prefix: true

  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'


  def create_friendship
    Friendship.create(user_id: requester_id, friend_id: requestee_id)
  end
end
