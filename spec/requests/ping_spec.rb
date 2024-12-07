require 'rails_helper'

RSpec.describe 'GET /ping' do
  context 'successful response' do
    it 'returns correct response' do
      get '/ping'
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({ status: :pong }.to_json)
    end
  end
end