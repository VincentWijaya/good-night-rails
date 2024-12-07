require 'rails_helper'

RSpec.describe 'POST /api/v1/unfollow' do
  before do
    create(:user, id: 1, name: 'User 1')
    create(:user, id: 2, name: 'User 2')
  end

  context 'with invalid authentication' do
    it 'returns unauthorized status' do
      post '/api/v1/unfollow/2'
      expect(response).to have_http_status :unauthorized
    end
  end

  context 'with valid authentication' do
    it 'returns ok status when request is valid' do
      create(:following, user_id: 1, following_user_id: 2)
      post '/api/v1/unfollow/2', headers: { 'Authorization' => User.first.api_key }
      expect(response).to have_http_status :ok  
    end
  end
end