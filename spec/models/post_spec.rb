require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post) }
  let!(:posts) { create_list(:post, 4) }

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

    it 'tests the comments association' do
      should have_many(:comments)
    end
  end

  describe 'Scopes' do
    it 'has the last post inserted as the first one in the array' do
      expect(Post.latest.first).to eq(posts.last)
    end

    it 'has posts ordered in descending order' do
      expect(Post.latest).to eq(posts.reverse)
    end

  end
end
