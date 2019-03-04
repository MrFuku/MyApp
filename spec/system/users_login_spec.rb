require 'rails_helper'

describe "UsersLogin", type: :system do
  context "ログインに失敗した時" do
    before do
      visit login_path
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      click_button "Log in"
    end

    it "ログイン画面が再表示されること" do
      expect(page).to have_selector 'h1', text: "Log in"
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_css 'div.alert-danger'
    end
  end
end
