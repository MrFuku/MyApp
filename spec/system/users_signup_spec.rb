require 'rails_helper'

describe "UsersSignup", type: :system do
  context "無効なユーザー情報を登録しようとした時" do
    it "登録に失敗すること" do
      visit signup_path
      expect {
        fill_in "Name", with: ""
        fill_in "Email", with: "user@invalid"
        fill_in "Password", with: "foo"
        fill_in "Confirmation", with: "bar"
        click_button "Create my account"
      }.to change(User, :count).by(0)
      expect(current_path).to eq signup_path
      expect(page).to have_css "div.alert-danger"
    end
  end

  context "有効なユーザー情報を登録しようとした時" do
    it "登録に成功すること" do
      skip
      visit signup_path
      expect {
        fill_in "Name", with: "valid user"
        fill_in "Email", with: "valise@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirmation", with: "password"
        click_button "Create my account"
      }.to change(User, :count).by(1)
      assert_redirected_to root_path
      # expect(page).to have_selector "h1", text: "valid user"
      # expect(page).to have_css "div.alert-success"
    end
  end
end
