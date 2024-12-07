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

  context 'when user tries to follow a user that does not exist' do
    it 'returns an error' do
      result = described_class.call(current_user: User.first, params: { following_user_id: 2 })

      expect(result).to be_a(FollowingServices::Follow::Error)
      expect(result.message).to eq("Following user not found")
    end
  end

  context 'when user tries to follow a user that already follows' do
    before do
      create(:user, id: 2, name: 'User 2')
      create(:following, user_id: 1, following_user_id: 2)
    end

    it 'returns an error' do
      result = described_class.call(current_user: User.first, params: { following_user_id: 2 })

      expect(result).to be_a(FollowingServices::Follow::Error)
      expect(result.message).to eq("You are already follow User 2")
    end
  end

  context 'when user tries to follow a user that does not follow' do
    before do
      create(:user, id: 2, name: 'User 2')
    end

    it 'creates a following' do
      result = described_class.call(current_user: User.first, params: { following_user_id: 2 })

      expect(result).to be_a(Following)
      expect(result.user_id).to eq(1)
      expect(result.following_user_id).to eq(2)
    end
  end
end