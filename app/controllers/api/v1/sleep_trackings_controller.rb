module Api::V1
  class SleepTrackingsController < Api::V1::ApplicationController
    def index
      result = current_user.following_users.last_week_sleep_trackings.sort_by { |record| -record.sleep_duration.to_i }

      render json: SleepTrackingSerializer.new(result).serializable_hash, status: :ok
    end

    def clock_in
      result = SleepTrackServices::ClockIn.call(current_user: current_user)

      if result.is_a?(SleepTrackServices::ClockIn::Error)
        render json: { error: result.message }, status: :bad_request
      else
        render json: SleepTrackingSerializer.new(result).serializable_hash
      end
    end
  end
end