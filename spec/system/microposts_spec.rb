require 'rails_helper'

describe "Microposts", type: :system do
  before do
    @user = create(:user)
    sign_in @user
    visit root_path
    fill_in "micropost_content", with: "first post"
    click_on "Post"
  end

  it "作成した投稿がホーム画面で表示されること" do
    expect(page).to have_content "first post"
    expect(page).to have_selector "div.alert-success",
      text: "Micropost created!"
  end

  it "作成した投稿がユーザー画面で表示されること" do
    visit user_path @user
    expect(page).to have_content "first post"
  end

  it "無効な投稿は登録されないこと" do
    fill_in "micropost_content", with: ""
    click_on "Post"
    expect(page).to have_selector "div.alert-danger",
      text: "The form contains 1 error."
  end

  it "投稿を削除できること" do
    expect(page).to have_link "delete"
    expect{
      click_link "delete"
      page.driver.browser.switch_to.alert.text.should == "You sure?"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_selector "div.alert-success",
        text: "Micropost deleted"
    }.to change(Micropost, :count).by(-1)
  end

  it "削除リンクが投稿者以外に表示されないこと" do
    other = create(:user)
    sign_in other
    visit user_path @user
    expect(page).to have_content "first post"
    expect(page).to have_no_link "delete"
  end
end
