require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    user1 = create(:user)
    user2 = create(:user)
    @relationship = Relationship.new(follower_id: user1.id,
                                     followed_id: user2.id)
  end

  context "有効なリレーションの場合" do
    it "バリデーションが有効であること" do
      expect(@relationship).to be_valid
    end
  end

  context "follower_idがnilの時" do
    it "バリデーションが無効であること" do
      @relationship.follower_id = nil
      expect(@relationship).to be_invalid
    end
  end

  context "followed_idがnilの時" do
    it "バリデーションが無効であること" do
      @relationship.followed_id = nil
      expect(@relationship).to be_invalid
    end
  end

  it "フォローとフォロー解除ができること" do
    jack = create(:user)
    bob = create(:user)
    expect(jack.following?(bob)).to be_falsy
    jack.follow(bob)
    expect(jack.following?(bob)).to be_truthy
    expect(bob.followers.include?(jack)).to be_truthy
    jack.unfollow(bob)
    expect(jack.following?(bob)).to be_falsy
  end
end
