require 'rails_helper'

RSpec.describe "StaticPages", type: :request do

  describe "GET #home" do
    it "レスポンスが正常なこと" do
      get root_path
      expect(response).to have_http_status(:success)
      assert_select "title", full_title("")
    end
  end

  describe "GET #help" do
    it "レスポンスが正常なこと" do
      get help_path
      expect(response).to have_http_status(:success)
      assert_select "title", full_title("Help")
    end
  end
  
  describe "GET #about" do
    it "レスポンスが正常なこと" do
      get about_path
      expect(response).to have_http_status(:success)
      assert_select "title", full_title("About")
    end
  end

  describe "GET #contact" do
    it "レスポンスが正常なこと" do
      get contact_path
      expect(response).to have_http_status(:success)
      assert_select "title", full_title("Contact")
    end
  end
end
