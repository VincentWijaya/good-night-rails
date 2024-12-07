class FollowingSerializer
  include JSONAPI::Serializer

  attributes :user_id, :following_user_id, :created_at, :updated_at
end