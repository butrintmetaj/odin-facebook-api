class CommentSerializer
  include JSONAPI::Serializer
  attributes :id, :body

  belongs_to :user
  belongs_to :post
end
