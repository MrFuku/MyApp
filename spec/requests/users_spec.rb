require 'rails_helper'

RSpec.describe "users", type: :request do
  base_title =  "Ruby on Rails Tutorial Sample App"

  describe "Get #show" do
    context "ユーザーが存在する場合" do
      let(:user) { create :user }
      before { get user_path user }
      expect_title = "jiro | #{base_title}"

      it "レスポンスが正常である" do
        expect(response).to have_http_status(:success)
      end

      it "タイトルの表示が「ユーザー名 | #{base_title}」であること" do
        assert_select "title", expect_title
      end

      it "ユーザー名が表示されていること" do
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
end
