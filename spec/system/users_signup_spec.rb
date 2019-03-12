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
    it "登録に成功し、メール認証後アカウントが有効になること" do
      visit signup_path
      expect {
        fill_in "Name", with: "valid user"
        fill_in "Email", with: "valise@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirmation", with: "password"
        click_button "Create my account"
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
      expect(page).to have_selector "div.alert-success",
        text: "A message with a confirmation link has been sent to your email address"

      user = User.last

      # アカウントが有効になっていない状態ではログインできず、メール認証を促すメッセージが表示される
      click_link "Log in"
      fill_in "Email", with: "valise@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"
      expect(page).to have_selector "div.alert-danger",
        text: "You have to confirm your email address before continuing."

      # メールに添付されている認証用リンクに遷移後、アカウントが有効になりログイン状態になる
      token = user.confirmation_token
      visit user_confirmation_path(confirmation_token: token)
      expect(page).to have_selector "h1", text: user.name
      expect(page).to have_selector "div.alert-success",
        text: "Your email address has been successfully confirmed."

    end
  end
end
