require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { build(:like) }

  describe 'Association' do
    it 'tests the likeable association' do
      should belong_to(:likeable)
    end

    it 'tests the user association' do
      should belong_to(:user)
    end
  end

end
