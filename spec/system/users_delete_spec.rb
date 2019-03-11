require 'rails_helper'

describe "UsersDelete", type: :system do
  context "管理者権限がない場合" do
    it "削除リンクが表示されないこと" do
      non_admin = create(:user)
      other = create(:user)
      sign_in non_admin
      visit users_path
      expect(page).to have_no_link "delete"
    end
  end

  context "管理者権限がある場合" do
    it "ユーザーを削除できること" do
      admin = create(:user,:admin)
      other = create(:user)
      sign_in admin
      visit users_path
      expect(page).to have_link "delete"
      expect{
        click_link "delete"
        page.driver.browser.switch_to.alert.text.should == "You sure?"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_css "div.alert-success"
      }.to change(User, :count).by(-1)
    end
  end
end
