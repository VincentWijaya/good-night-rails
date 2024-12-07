module SleepTrackServices
  # Clock in user
  class ClockIn < ApplicationService
    Error = Class.new(StandardError)

    def initialize(current_user:)
      @current_user = current_user
    end

    def call
      return Error.new('You are already clocked in') if recent_clocked_in.present?

      @current_user.sleep_trackings.create(clock_in: Time.zone.now)
      @current_user.sleep_trackings.sort_by { |record| -record.created_at.to_i }
    end

    private

    def recent_clocked_in
      @current_user.sleep_trackings.find_by(clock_out: nil, created_at: Time.zone.today.all_day)
    end
  end
end