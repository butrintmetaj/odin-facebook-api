require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  subject { create(:friend_request) }

  describe 'Association' do
    it 'tests the requester association' do
      should belong_to(:requester)
    end

    it 'tests the requestee association' do
      should belong_to(:requestee)
    end
  end

  describe 'Callbacks' do
    it 'runs an after commit callback that creates a friendship record when a friend request is updated to approved' do
      expect { subject.update(status: 'accepted') }.to change { Friendship.count }.by(1)
    end
  end
end
