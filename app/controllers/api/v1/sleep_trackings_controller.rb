module Api::V1
  class SleepTrackingsController < Api::V1::ApplicationController
    def index
      sleep_trackings = current_user.following_users.last_week_sleep_trackings
      paginated_sleep_trackings = sleep_trackings.page(params[:page]).per(params[:per_page] || 10).without_count
      sorted_sleep_trackings = paginated_sleep_trackings.sort_by { |record| -record.sleep_duration.to_i }

      render json: SleepTrackingSerializer.new(sorted_sleep_trackings).serializable_hash, status: :ok
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