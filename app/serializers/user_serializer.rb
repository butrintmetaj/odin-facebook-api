class UserSerializer
  include JSONAPI::Serializer

  include AvatarHelper

  attributes :id, :first_name, :last_name, :email, :birthday, :gender, :avatar

  attribute :avatar do |user|
    avatar_url(user)
  end

  attribute :friends do |user|
    FriendRequest.where(user_id: user.id, friend_id: params[:current_user_id])
                 .or(FriendRequest.where(user_id: params[:current_user_id], friend_id: user.id)).exists?
  end

  attribute :friends, if: Proc.new { |record, params|
    params && params[:current_user_id]
  } do |user, params|
    Friendship.where(user_id: user.id, friend_id: params[:current_user_id])
                 .or(Friendship.where(user_id: params[:current_user_id], friend_id: user.id)).exists?
  end

  has_many :posts

end
