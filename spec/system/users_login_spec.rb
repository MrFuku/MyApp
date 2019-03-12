require 'rails_helper'

describe "UsersLogin", type: :system do
  before { @user = create(:user) }

  context "不正な値を入力した時" do
    before do
      visit login_path
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      click_button "Log in"
    end

    it "エラーメッセージが表示されること" do
      expect(current_path).to eq login_path
      expect(page).to have_css 'div.alert-danger'
    end
  end

  context "妥当な値を入力した時" do
    before do
      visit login_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
    end

    it "ログインに成功すること" do
      expect(current_path).to eq user_path @user
      aggregate_failures do
        expect(page).to have_no_link "Log in"
        click_on('Account')
        expect(page).to have_selector "div.alert-success",
          text: "Signed in successfully."
        expect(page).to have_link "Log out"
        expect(page).to have_link "Profile"
      end
    end

    it "ログアウトできること" do
      click_on('Account')
      click_on "Log out"
      expect(current_path).to eq root_path
      aggregate_failures do
        expect(page).to have_selector "div.alert-success",
          text: "Signed out successfully."
        expect(page).to have_link "Log in"
        expect(page).to have_no_link "Log out"
        expect(page).to have_no_link "Profile"
      end
    end
  end
end
