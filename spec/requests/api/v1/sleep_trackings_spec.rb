require 'rails_helper'

RSpec.describe 'GET /api/v1/sleep_trackings' do
  before do
    create(:user, id: 1, name: 'User 1')
    create(:user, id: 2, name: 'User 2')
    create(:following, user_id: 1, following_user_id: 2)
    create(:sleep_tracking, user_id: 2, clock_in: Time.zone.now - 8.hours, clock_out: Time.zone.now - 7.hours, sleep_duration: 3600)
  end

  context 'with invalid authentication' do
    it 'returns unauthorized status' do
      get '/api/v1/sleep_trackings'
      expect(response).to have_http_status :unauthorized
    end
  end

  context 'with valid authentication' do
    it 'returns ok status' do
      get '/api/v1/sleep_trackings', headers: { 'Authorization' => User.first.api_key }
      expect(response).to have_http_status :ok
    end
  end
end