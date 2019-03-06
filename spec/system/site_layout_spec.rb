require 'rails_helper'

describe "SiteLayoutTest", type: :system do
  link_name = headline = ""

  shared_examples "リンクの確認" do
    it "#{link_name}へのリンクが存在" do
      expect(page).to have_link link_name
    end
    it "#{headline}ページへ遷移できる" do
      click_on link_name
      expect(page).to have_selector 'h1', text: headline
    end
  end

  describe "homeページのレイアウト" do
    before { visit root_path }
    it "homeページのレイアウトが表示されているか" do
      expect(page).to have_selector 'h1', text: "My App"
    end

    link_name = "home"
    headline = "My App"
    it_behaves_like "リンクの確認"

    link_name = headline = "My App"
    it_behaves_like "リンクの確認"

    link_name = headline = "Help"
    it_behaves_like "リンクの確認"

    link_name = headline = "About"
    it_behaves_like "リンクの確認"

    link_name = headline = "Contact"
    it_behaves_like "リンクの確認"
  end
end
