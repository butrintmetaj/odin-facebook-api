require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  subject { build(:friend_request) }

  describe 'Association' do
    it 'tests the likeable association' do
      should belong_to(:requester)
    end

    it 'tests the user association' do
      should belong_to(:requestee)
    end
  end
end
