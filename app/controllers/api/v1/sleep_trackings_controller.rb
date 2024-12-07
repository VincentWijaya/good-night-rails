module Api::V1
  class SleepTrackingsController < Api::V1::ApplicationController
    def index
      result = current_user.following_users.last_week_sleep_trackings.sort_by { |record| -record.sleep_duration.to_i }

      render json: SleepTrackingSerializer.new(result).serializable_hash, status: :ok
    end
  end
end