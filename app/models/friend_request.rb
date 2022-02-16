class FriendRequest < ApplicationRecord

  enum status: {
    pending: 0,
    accepted: 1
  },_prefix: true

  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'


end
