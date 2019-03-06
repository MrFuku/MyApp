require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  base_title =  "Ruby on Rails Tutorial Sample App"

  describe "Get #new" do
    before { get signup_path }
    expect_title = "Sign up | #{base_title}"

    it "レスポンスが正常である" do
      expect(response).to have_http_status(:success)
    end

    it "タイトルの表示が「#{expect_title}」であること" do
      assert_select "title", expect_title
    end
  end

  describe "Post #create" do
    context "パラメータが妥当な場合" do
      it "レスポンスが正常(302)である" do
        post signup_path, params: { user: attributes_for(:valid_user) }
        expect(response).to have_http_status(302)
      end

      it "ユーザーが登録されること" do
        expect do
          post signup_path, params: { user: attributes_for(:valid_user) }
        end.to change(User, :count).by(1)
      end

      it "ユーザー詳細ページへリダイレクトされること" do
        post signup_path, params: { user: attributes_for(:valid_user) }
        expect(response).to redirect_to User.last
      end
    end

    context "パラメータが不正な場合" do
      it "レスポンスが正常である" do
        post signup_path, params: { user: attributes_for(:invalid_user) }
        expect(response).to have_http_status(:success)
      end

      it "ユーザーが登録されないこと" do
        expect do
          post signup_path, params: { user: attributes_for(:invalid_user) }
        end.to change(User, :count).by(0)
      end

      it 'エラーメッセージが表示されること' do
        post signup_path, params: { user: attributes_for(:invalid_user) }
        expect(response.body).to include 'prohibited this user from being saved'
      end
    end
  end
end
