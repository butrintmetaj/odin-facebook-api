class PostSerializer
  include JSONAPI::Serializer

  include AvatarHelper
  attributes :id, :body, :image

  attribute :image do |post|
    image_url(post)
  end

  has_many :comments
  belongs_to :user

end
