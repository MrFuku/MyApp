require 'rails_helper'

RSpec.describe "sessions", type: :request do
  base_title =  "Ruby on Rails Tutorial Sample App"

  describe "Get #new" do
    before { get login_path }
    expect_title = "Log in | #{base_title}"

    it "レスポンスが正常である" do
      expect(response).to have_http_status(:success)
    end

    it "タイトルの表示が「#{expect_title}」であること" do
      assert_select "title", expect_title
    end
  end

  describe "Post #create" do
    context "パラメーターが妥当な場合" do
      let(:user) { create(:user) }
      before do
        sign_in user
        get user_path user
      end

      it "レスポンスが正常である" do
        expect(response).to have_http_status(:success)
      end

      it "ログイン状態になること" do
        expect(controller.current_user).to eq(user)
      end
    end
  end

  describe "Delete #destroy" do
    before do

    end
    it "ログアウト状態が解除されること、またログアウト時にログアウトしてもエラーが起きないこと" do
      user = create(:user)
      sign_in user
      get user_path user
      expect(controller.current_user).to eq(user)
      sign_out user
      get root_path
      expect(controller.current_user).to be_nil
      sign_out user
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
