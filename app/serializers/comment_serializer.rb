class CommentSerializer
  include JSONAPI::Serializer
  attributes :id, :body, :likes_count

  belongs_to :user
  belongs_to :post
end
