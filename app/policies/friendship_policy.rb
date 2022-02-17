class FriendshipPolicy < ApplicationPolicy
  attr_reader :user, :friendship

  def initialize(user, friendship)
    @user = user
    @friendship = friendship
  end

  def destroy?
    user.id == friendship.user_id || user.id == friendship.friend_id
  end
end
