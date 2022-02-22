require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  subject { build(:friend_request) }

  describe 'Association' do
    it 'tests the requester association' do
      should belong_to(:requester)
    end

    it 'tests the requestee association' do
      should belong_to(:requestee)
    end
  end
end
