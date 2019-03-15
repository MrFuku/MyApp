require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before do
    @user = create(:user)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  context "有効なマイクロポストの場合" do
    it "バリデーションが有効であること" do
      expect(@micropost).to be_valid
    end
  end

  context "ユーザーと関連付けされていない時" do
    it "バリデーションが無効であること" do
      @micropost.user_id = nil;
      expect(@micropost).to be_invalid
    end
  end

  describe "投稿文字数にに対する検証" do
    context "投稿が空の時" do
      it "バリデーションが無効であること" do
        @micropost.content = "     ";
        expect(@micropost).to be_invalid
      end
    end

    context "投稿が140文字の時" do
      it "バリデーションが有効であること" do
        @micropost.content = "a" * 140
        expect(@micropost).to be_valid
      end
    end

    context "投稿が141文字の時" do
      it "バリデーションが無効であること" do
        @micropost.content = "a" * 141
        expect(@micropost).to be_invalid
      end
    end
  end

  it "マイクロポストのレコードが作成が新しい順に並んでいること" do
    @user.microposts.create(content: "2years ago", created_at: 2.years.ago)
    @user.microposts.create(content: "just now", created_at: Time.zone.now)
    @user.microposts.create(content: "10minutes ago", created_at: 10.minutes.ago)
    expect(Micropost.first.content).to eq "just now"
  end

  it "ユーザーの削除に合わせて関連する投稿も削除されること" do
    @micropost.save!
    expect {
      @user.destroy
    }.to change(Micropost, :count).by(-1)
  end
end
