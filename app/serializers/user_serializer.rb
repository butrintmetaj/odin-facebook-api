class UserSerializer
  include JSONAPI::Serializer

  include AvatarHelper

  attributes :id, :first_name, :last_name, :email, :birthday, :gender, :avatar

  attribute :avatar do |user|
    avatar_url(user)
  end

  has_many :posts

end
