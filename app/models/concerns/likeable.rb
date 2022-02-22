module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable, dependent: :destroy
  end

  def likes_count
    likes.count
  end

  def is_liked_by(user_id)
    likes.where(user_id: user_id).exists?
  end

  def like(user_id)
    likes.create(user_id: user_id) unless is_liked_by(user_id)
  end

  def unlike(user_id)
    likes.find_by(user_id: user_id).destroy if is_liked_by(user_id)
  end
end