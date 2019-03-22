require 'rails_helper'

describe "Following", type: :system do
  before do
    @user = create(:user)
    sign_in @user
  end

  it "Followingページに自分がフォローしているユーザーが表示されていること" do
    follower = create(:user)
    unfollower = create(:user)
    @user.follow(follower)
    visit following_user_path(@user)
    expect(page).to have_content follower.name
    expect(page).to have_no_content unfollower.name
  end

  it "Followersページに自分をフォローしているユーザーが表示されていること" do
    followed = create(:user)
    unfollowed = create(:user)
    followed.follow(@user)
    visit followers_user_path(@user)
    expect(page).to have_content followed.name
    expect(page).to have_no_content unfollowed.name
  end

  it "ユーザーのフォローとアンフォローができること" do
    other = create(:user)
    visit user_path other
    expect(page).to have_button 'フォローする'
    expect(page).to have_no_button 'フォロー中'
    expect {
      click_on "フォローする"
      sleep 0.1
    }.to change(Relationship, :count).by(1)
    expect(page).to have_button 'フォロー中'
    expect(page).to have_no_button 'フォローする'
    expect {
      click_on "フォロー中"
      sleep 0.1
    }.to change(Relationship, :count).by(-1)
  end
end
