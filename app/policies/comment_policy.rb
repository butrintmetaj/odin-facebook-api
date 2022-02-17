class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def update?
    user.id == comment.user_id
  end

  def destroy?
    user.id == comment.user_id || user_id == comment.post.user_id
  end
end
