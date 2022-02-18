class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar
  has_many :posts
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: 'requester_id'
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: 'requestee_id'
  has_many :comments
  has_many :friendships
  has_many :reverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  enum gender: {
    not_specified: 0,
    female: 1,
    male: 2
  }

  validates :first_name, presence: true, length: { in: 2..50 }
  validates :last_name, presence: true, length: { in: 2..50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 250 }, on: :create
  validates :password, presence: true, length: { in: 8..16 }, confirmation: true, on: :create
  validates :birthday, date: { before: Proc.new { Date.today } }
  validates :gender, presence: true, inclusion: { in: %w[not_specified female male], message: '%{value} is not a valid status' }
  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..(5.megabytes) }

  def friends_ids
    friendships.pluck(:friend_id) + reverse_friendships.pluck(:user_id)
  end

  def friends
    User.where(id: friends_ids)
  end

end
