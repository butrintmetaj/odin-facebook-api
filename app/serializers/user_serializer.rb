class UserSerializer
  include JSONAPI::Serializer

  include AvatarHelper

  attributes :id, :first_name, :last_name, :email, :birthday, :gender, :avatar

  attribute :avatar do |user|
    avatar_url(user)
  end

  attribute :friends, if: Proc.new { |record, params|
    params && params[:current_user_id]
  } do |user, params|
    user.friendships.find { |f| f.friend_id == params[:current_user_id] }.present? ||
      user.reverse_friendships.find { |f| f.user_id == params[:current_user_id] }.present?
  end

  has_many :posts

end
