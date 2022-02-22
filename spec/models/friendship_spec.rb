require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Association' do
    it 'tests the user association' do
      should belong_to(:user)
    end

    it 'tests the friend association' do
      should belong_to(:friend)
    end
  end
end
