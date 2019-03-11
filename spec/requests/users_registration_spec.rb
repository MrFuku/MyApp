require 'rails_helper'

RSpec.describe "UsersRagistration", type: :request do

  describe "Delete #destroy" do
    context "管理者権限がない場合" do
      it "ユーザーを削除できないこと" do
        non_admin = create(:user)
        other = create(:user)
        sign_in non_admin
        expect{
          delete user_delete_path other
          assert_redirected_to root_path
        }.to change(User, :count).by(0)
      end
    end

    context "管理者権限がある場合" do
      it "ユーザーを削除できること" do
        admin = create(:user, :admin)
        other = create(:user)
        sign_in admin
        expect{
          delete user_delete_path other
          assert_redirected_to users_path
        }.to change(User, :count).by(-1)
      end
    end
  end
end
