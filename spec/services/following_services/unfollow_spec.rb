require 'rails_helper'

RSpec.describe FollowingServices::Unfollow do
  before do
    create(:user, id: 1, name: 'User 1')
  end

  context 'when user tries to unfollow himself' do
    it 'returns an error' do
      result = described_class.call(current_user: User.first, params: { following_user_id: 1 })

      expect(result).to be_a(FollowingServices::Unfollow::Error)
      expect(result.message).to eq("You can't unfollow your self")
    end
  end

  context 'when user tries to unfollow a user that does not exist' do
    it 'returns an error' do
      result = described_class.call(current_user: User.first, params: { following_user_id: 2 })

      expect(result).to be_a(FollowingServices::Unfollow::Error)
      expect(result.message).to eq("User not found")
    end
  end

  context 'when user tries to unfollow a user that does not follow' do
    it 'returns an error' do
      create(:user, id: 2, name: 'User 2')

      result = described_class.call(current_user: User.first, params: { following_user_id: 2 })

      expect(result).to be_a(FollowingServices::Unfollow::Error)
      expect(result.message).to eq("You are not following User 2")
    end
  end

  context 'when user tries to unfollow a user that follows' do
    before do
      create(:user, id: 2, name: 'User 2')
      create(:following, user_id: 1, following_user_id: 2)
    end

    it 'unfollows the user' do
      result = described_class.call(current_user: User.first, params: { following_user_id: 2 })

      expect(result).not_to be_a(FollowingServices::Unfollow::Error)
      expect(Following.count).to eq(0)
    end
  end
end