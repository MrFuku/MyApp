require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = create(:user)
    @micropost = @user.microposts.create(content: "Lorem ipsum")
    @comment = Comment.new(content: "com", micropost_id: @micropost.id, user_id: @user.id)
  end

  context "有効なコメントの場合" do
    it "バリデーションが有効であること" do
      expect(@comment).to be_valid
    end
  end

  context "ユーザーと関連付けされていない時" do
    it "バリデーションが無効であること" do
      @comment.user_id = nil;
      expect(@comment).to be_invalid
    end
  end

  describe "投稿文字数にに対する検証" do
    context "投稿が空の時" do
      it "バリデーションが無効であること" do
        @comment.content = "     ";
        expect(@comment).to be_invalid
      end
    end

    context "投稿が140文字の時" do
      it "バリデーションが有効であること" do
        @comment.content = "a" * 140
        expect(@comment).to be_valid
      end
    end

    context "投稿が141文字の時" do
      it "バリデーションが無効であること" do
        @comment.content = "a" * 141
        expect(@comment).to be_invalid
      end
    end
  end

  it "コメントのレコードが作成が古い順に並んでいること" do
    Comment.new(micropost_id: @micropost.id, user_id: @user.id, content: "just now", created_at: Time.zone.now).save!
    Comment.new(micropost_id: @micropost.id, user_id: @user.id, content: "2years ago", created_at: 2.years.ago).save!
    Comment.new(micropost_id: @micropost.id, user_id: @user.id, content: "10minutes ago", created_at: 10.minutes.ago).save!
    expect(Comment.count).to eq 3
    expect(Comment.first.content).to eq "2years ago"
  end

  it "ユーザーの削除に合わせて関連するコメントも削除されること" do
    other = create(:user)
    Comment.new(micropost_id: @micropost.id, user_id: other.id, content: "destroy comment").save!
    expect {
      other.destroy
    }.to change(Comment, :count).by(-1)
  end

  it "マイクロポストの削除に合わせて関連するコメントも削除されること" do
    @comment.save!
    expect {
      @micropost.destroy
    }.to change(Comment, :count).by(-1)
  end
end
