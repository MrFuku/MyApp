require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  base_title =  "Ruby on Rails Tutorial Sample App"
  
  describe "GET #home" do
    before { get root_path }
    expect_title = base_title

    it "レスポンスが正常である" do
      expect(response).to have_http_status(:success)
    end

    it "タイトルの表示が「#{expect_title}」であること" do
      assert_select "title", expect_title
    end
  end

  describe "GET #help" do
    before { get help_path }
    expect_title = "Help | #{base_title}"

    it "レスポンスが正常である" do
      expect(response).to have_http_status(:success)
    end

    it "タイトルの表示が「#{expect_title}」であること" do
      assert_select "title", expect_title
    end
  end

  describe "GET #about" do
    before { get about_path }
    expect_title = "About | #{base_title}"

    it "レスポンスが正常である" do
      expect(response).to have_http_status(:success)
    end

    it "タイトルの表示が「#{expect_title}」であること" do
      assert_select "title", expect_title
    end
  end

  describe "GET #contact" do
    before { get contact_path }
    expect_title = "Contact | #{base_title}"

    it "レスポンスが正常である" do
      expect(response).to have_http_status(:success)
    end

    it "タイトルの表示が「#{expect_title}」であること" do
      assert_select "title", expect_title
    end
  end
end
