require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "Get #show" do
    context "ユーザーが存在する場合" do
      it "ユーザーの詳細画面を表示すること" do
        user = create(:user)
        get user_path user
        expect(response).to have_http_status(:success)
        assert_select "title", full_title(user.name)
        expect(response.body).to include user.name
      end
    end

    context "ユーザーが存在しない場合" do
      subject { -> { get user_path 1 } }
      it "「ActiveRecord::RecordNotFound」エラーになること" do
        is_expected.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "Get #index" do
    context "未ログイン時" do
      it "ログイン画面にリダイレクトされること" do
        get users_path
        assert_redirected_to login_url
      end
    end

    context "ログイン時" do
      it "ユーザー一覧画面が表示されること" do
        user = create(:user)
        sign_in user
        get users_path
        expect(response).to have_http_status(:success)
        assert_select "title", full_title("All users")
      end
    end
  end
end
