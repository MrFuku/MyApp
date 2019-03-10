require 'rails_helper'

RSpec.describe "users", type: :request do

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
end
