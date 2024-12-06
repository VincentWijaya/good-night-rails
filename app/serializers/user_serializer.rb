class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :api_key, :created_at, :updated_at
end