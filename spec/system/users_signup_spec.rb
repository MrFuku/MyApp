require 'rails_helper'

describe "UsersSignup", type: :system do
  before do
    @invalid_user = User.new(
      name: "",
      email: "user@invalid",
      password: "foo",
      password_confirmation: "bar"
    )
  end

  context "無効なユーザー情報を登録しようとした時" do
    it "データベースにユーザーが登録されないこと" do
      visit signup_path
      expect {
        fill_in "Name", with: ""
        fill_in "Email", with: "user@invalid"
        fill_in "Password", with: "foo"
        fill_in "Confirmation", with: "bar"
        click_button "Create my account"
      }.to change(User, :count).by(0)
      expect(page).to have_selector 'h1', text: "Sign up"
    end
  end

  context "有効なユーザー情報を登録しようとした時" do
    it "データベースにユーザーが登録されること" do
      visit signup_path
      expect {
        fill_in "Name", with: "valid user"
        fill_in "Email", with: "valid@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirmation", with: "password"
        click_button "Create my account"
      }.to change(User, :count).by(1)
      expect(page).to have_selector 'h1', text: "valid user"
      expect(page).to have_selector 'div.alert-success', text: "Welcome to the Sample App!"
    end
  end
end
