require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'Validations' do
    it 'is valid with all valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without first_name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without last name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without birthday' do
      subject.birthday = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without gender' do
      subject.gender = nil
      expect(subject).to_not be_valid
    end

    it 'is not a valid first_name if it is lower than 2 characters' do
      subject.last_name = 'a'
      expect(subject).to_not be_valid
    end

    it 'is not a valid last_name if it is lower than 2 characters' do
      subject.last_name = 'a'
      expect(subject).to_not be_valid
    end

    it 'is not a valid password if it is lower than 8 characters' do
      subject.password = 'a'
      expect(subject).to_not be_valid
    end

    it 'is not a valid password if it is more than 16 characters' do
      subject.password = 'a' * 20
      expect(subject).to_not be_valid
    end

    it 'is not valid if birthday is a future date' do
      subject.birthday = '2052-10-10'
      expect(subject).to_not be_valid
    end
  end

  describe 'Association' do
    it 'tests the post association' do
      should have_many(:posts)
    end

    it 'tests the comments association' do
      should have_many(:comments)
    end

    it 'tests the friendships association' do
      should have_many(:friendships)
    end

    it 'tests the likes association' do
      should have_many(:likes)
    end

    it 'tests the friendships association' do
      should have_many(:reverse_friendships).class_name('Friendship')
    end

    it 'tests the received friend requests association' do
      should have_many(:received_friend_requests).class_name('FriendRequest')
    end

    it 'tests the received friend requests association' do
      should have_many(:sent_friend_requests).class_name('FriendRequest')
    end
  end

end
