class FriendRequestSerializer
  include JSONAPI::Serializer
  attributes :id, :status

  belongs_to :requester, serializer: UserSerializer
  belongs_to :requestee, serializer: UserSerializer

end
