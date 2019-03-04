require 'rails_helper'

describe "UsersLogin", type: :system do
  before do
    @user = create(:user)
  end
  context "ログインに失敗した時" do
    before do
      visit login_path
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      click_button "Log in"
    end

    it "ログイン画面が再表示されること" do
      expect(current_path).to eq login_path
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_css 'div.alert-danger'
    end
  end

  context "ログインに成功した時" do
    before do
      visit login_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
    end

    it "ユーザー詳細画面にリダイレクトされること" do
      expect(current_path).to eq user_path @user
    end

    it "ログインリンクが表示されないていないこと" do
      expect(page).to have_no_link "Log in"
    end

    it "ログアウトリンクが表示されること" do
      click_on('Account')
      expect(page).to have_link "Log out"
    end

    it "ユーザー詳細へのリンクが表示されていること" do
      click_on('Account')
      expect(page).to have_link "Profile"
    end

    context "ログイン後、ログアウトリンクを押した時" do
      before do
        click_on('Account')
        click_on "Log out"
      end

      it "homeページへリダイレクトされること" do
        expect(current_path).to eq root_path
      end

      it "ログインリンクが表示されていること" do
        expect(page).to have_link "Log in"
      end

      it "ログアウトリンクが表示されていないこと" do
        expect(page).to have_no_link "Log out"
      end

      it "ユーザー詳細へのリンクが表示されていない" do
        expect(page).to have_no_link "Profile"
      end
    end
  end
end
