require 'rails_helper'

describe "UsersSignup", type: :system do
  context "無効なユーザー情報を登録しようとした時" do
    before do
      @before_user_count = User.all.count
      visit signup_path
      fill_in "Name", with: ""
      fill_in "Email", with: "user@invalid"
      fill_in "Password", with: "foo"
      fill_in "Confirmation", with: "bar"
      click_button "Create my account"
    end

    it "データベースにユーザーが登録されないこと" do
      expect(User.all.count).to eq @before_user_count
    end

    it "サインアップページが再表示されること" do
      expect(page).to have_selector 'h1', text: "Sign up"
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_css 'div.alert-danger'
    end
  end

  context "有効なユーザー情報を登録しようとした時" do
    before do
      visit signup_path
      @before_user_count = User.all.count
      fill_in "Name", with: "valid user"
      fill_in "Email", with: "valid@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirmation", with: "password"
      click_button "Create my account"
    end

    it "データベースにユーザーが登録されること" do
      expect(User.all.count).to eq @before_user_count + 1
    end

    it "ユーザー詳細画面にリダイレクトされること" do
      expect(page).to have_selector 'h1', text: "valid user"
    end

    it "登録成功メッセージが表示されること" do
      expect(page).to have_css 'div.alert-success'
    end
  end
end
