class SleepTrackingSerializer
  include JSONAPI::Serializer

  attributes :user_id, :clock_in, :clock_out, :sleep_duration
end