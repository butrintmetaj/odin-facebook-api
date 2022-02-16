class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    user.id == post.user_id
  end

  def destroy?
    user.id == post.user_id
  end
end
