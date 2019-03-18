require 'rails_helper'

describe "UsersSearch", type: :system do
  it "検索に応じて適切なユーザーが抽出されること" do
    jack = create(:user, name: 'jack')
    alice = create(:user, name: 'alice')

    sign_in jack
    visit users_path

    expect(page).to have_selector "h1", text: "All users"
    expect(page).to have_content "jack"
    expect(page).to have_content "alice"

    fill_in "User Search", with: "li"
    click_on "Go"
    expect(page).to have_selector "h1", text: "Search Result"
    expect(page).to have_no_content "jack"
    expect(page).to have_content "alice"

    fill_in "User Search", with: "ja"
    click_on "Go"
    expect(page).to have_selector "h1", text: "Search Result"
    expect(page).to have_content "jack"
    expect(page).to have_no_content "alice"
  end
end
