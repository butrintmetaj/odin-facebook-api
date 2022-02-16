class FriendRequest < ApplicationRecord

  enum status: {
    pending: 0,
    accepted: 1
  }

  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'

end
