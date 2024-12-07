require 'rails_helper'

RSpec.describe 'POST /api/v1/users' do
  context 'with invalid request' do
    it 'returns unprocessable entity when request is empty' do
      params = {}
      post '/api/v1/users', params: params
      expect(response).to have_http_status :unprocessable_entity
      expect(response.body).to include("Name can't be blank")
    end

    it 'returns unprocessable entity when name format is invalid' do
      params = { name: 'SELECT * FROM' }
      post '/api/v1/users', params: params
      expect(response).to have_http_status :unprocessable_entity
      expect(response.body).to include('Format not Supported')
    end
  end

  context 'with valid request' do
    it 'returns created status when request is valid' do
      params = { name: 'John Doe' }
      post '/api/v1/users', params: params
      expect(response).to have_http_status :created
      expect(response.body).to include('John Doe')
      expect(response.body).to include('api_key')
    end
  end
end
