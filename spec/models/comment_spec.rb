require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  describe 'Validations' do
    it 'is valid with all valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid if body is nil' do
      subject.body = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if body length is greater than 100' do
      subject.body = 'A' * 120
      expect(subject).to_not be_valid
    end

    it 'is not valid if body length is lower than 10' do
      subject.body = 'A'
      expect(subject).to_not be_valid
    end
  end

  describe 'Association' do
    it 'tests the user association' do
      should belong_to(:user)
    end

    it 'tests the post association' do
      should belong_to(:post)
    end

    it 'tests the likes association' do
      should have_many(:likes)
    end
  end


end
