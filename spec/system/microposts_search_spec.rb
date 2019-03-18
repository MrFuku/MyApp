require 'rails_helper'

describe "micropostsSearch", type: :system do
  before do
    @user = create(:user)
    @other = create(:user)
    @user.microposts.create(content: "first post")
    @user.microposts.create(content: "second post")
    @other.microposts.create(content: "other first")
    @other.microposts.create(content: "other second")
    sign_in @user
    @user.follow(@other)
  end

  it "home画面で記事の検索が行えること" do
    visit root_path
    expect(page).to have_content "first post"
    expect(page).to have_content "second post"
    expect(page).to have_content "other first"
    expect(page).to have_content "other second"

    fill_in "Micoropost Search", with: "first"
    click_on "Go"
    expect(page).to have_content "first post"
    expect(page).to have_no_content "second post"
    expect(page).to have_content "other first"
    expect(page).to have_no_content "other second"

    fill_in "Micoropost Search", with: "second"
    click_on "Go"
    expect(page).to have_no_content "first post"
    expect(page).to have_content "second post"
    expect(page).to have_no_content "other first"
    expect(page).to have_content "other second"
  end

  it "user詳細画面で記事の検索が行えること" do
    visit user_path @user
    expect(page).to have_content "first post"
    expect(page).to have_content "second post"
    expect(page).to have_no_content "other first"
    expect(page).to have_no_content "other second"

    fill_in "Micoropost Search", with: "first"
    click_on "Go"
    expect(page).to have_content "first post"
    expect(page).to have_no_content "second post"
    expect(page).to have_no_content "other first"
    expect(page).to have_no_content "other second"

    fill_in "Micoropost Search", with: "second"
    click_on "Go"
    expect(page).to have_no_content "first post"
    expect(page).to have_content "second post"
    expect(page).to have_no_content "other first"
    expect(page).to have_no_content "other second"
  end
end
