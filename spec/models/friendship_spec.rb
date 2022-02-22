require 'rails_helper'

RSpec.describe Friendship, type: :model do
  subject { create(:friendship) }
  let!(:friend_request) { create(:friend_request, requester_id: subject.user_id, requestee_id: subject.friend_id) }

  describe 'Association' do
    it 'tests the user association' do
      should belong_to(:user)
    end

    it 'tests the friend association' do
      should belong_to(:friend)
    end

    describe 'Callbacks' do
      it 'runs an after commit callback that deletes the friend request record when a friendship is deleted' do
        expect { subject.destroy }.to change { FriendRequest.count }.by(-1)
      end
    end
  end
end
