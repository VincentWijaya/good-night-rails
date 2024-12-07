require 'rails_helper'

RSpec.describe FollowingServices::Follow do
  before do
    create(:user, id: 1, name: 'User 1')
  end

  context 'when user tries to follow himself' do
    it 'returns an error' do
      result = described_class.call(current_user: User.first, params: { following_user_id: 1 })

      expect(result).to be_a(FollowingServices::Follow::Error)
      expect(result.message).to eq("You can't follow your self")
    end
  end
end