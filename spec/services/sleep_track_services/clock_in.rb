require 'rails_helper'

RSpec.describe SleepTrackServices::ClockIn do
  before do
    create(:user, id: 1, name: 'User 1')
  end

  context 'when user tries to clock in twice in same day' do
    it 'returns an error' do
      create(:sleep_tracking, user_id: 1, clock_in: Time.zone.now, clock_out: nil)

      result = described_class.call(current_user: User.first)

      expect(result).to be_a(SleepTrackServices::ClockIn::Error)
      expect(result.message).to eq('You are already clocked in today!')
    end
  end

  context 'when user tries to clock in' do
    it 'returns the sleep tracking records' do
      result = described_class.call(current_user: User.first)

      expect(result.first).to be_a(SleepTracking)
      expect(result.first.user_id).to eq(1)
      expect(result.first.clock_in).to be_present
      expect(result.first.clock_out).to be_nil
    end
  end
end