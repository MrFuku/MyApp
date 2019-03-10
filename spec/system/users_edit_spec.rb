require 'rails_helper'

describe "UsersEdit", type: :system do
  before do
    @user = create(:user)
  end
  
  context "ログイン時" do
    before do
      sign_in @user
    end

    context "パラメーターが妥当な場合" do
      it "ユーザー情報の編集に成功すること" do
        visit edit_user_path
        fill_in "Name", with: "after name"
        fill_in "Current password", with: @user.password
        click_button "Save changes"
        expect(current_path).to eq user_path @user
        expect(@user.reload.name).to eq "after name"
        expect(page).to have_css "div.alert-success"
      end
    end

    context "パラメーターが不正な場合" do
      it "ユーザー情報の編集に失敗すること" do
        visit edit_user_path
        fill_in "Name", with: ""
        fill_in "Email", with: "invalid@mail"
        fill_in "Current password", with: "invalidpassword"
        click_button "Save changes"
        expect(current_path).to eq edit_user_path
        expect(page).to have_css "div.alert-danger"
      end
    end
  end

  context "未ログインの場合" do
    it "ユーザー編集しようとするとログインページにリダイレクトされること" do
      visit edit_user_path
      expect(current_path).to eq login_path
    end
  end
end
