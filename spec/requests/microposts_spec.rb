require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  describe "POST #create" do
    context "未ログイン時" do
      it "投稿ができないこと" do
        expect {
          post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
        }.to change(Micropost, :count).by(0)
        assert_redirected_to login_path
      end
    end

    context "ログイン時" do
      it "投稿できること" do
        user = create(:user)
        sign_in user
        expect {
          post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
        }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @user = create(:user)
      @micropost = @user.microposts.create(content: "Lorem ipsum")
    end
    context "未ログイン時" do
      it "削除できないこと" do
        expect {
          delete micropost_path @micropost
        }.to change(Micropost, :count).by(0)
        assert_redirected_to login_path
      end
    end

    context "ログイン時" do
      it "削除できること" do
        sign_in @user
        expect {
          delete micropost_path @micropost
        }.to change(Micropost, :count).by(-1)
      end
    end

    context "別のユーザーの投稿を削除しようとした時" do
      it "削除できないこと" do
        other = create(:user)
        otherpost = other.microposts.create(content: "other post")
        sign_in @user
        expect {
          delete micropost_path otherpost
        }.to change(Micropost, :count).by(0)
      end
    end
  end
end
