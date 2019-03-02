require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  let(:title) { "#{page_title}#{base_title}" }

  shared_examples "レスポンス、タイトル確認" do
    it "レスポンスが正常である" do
      expect(response).to have_http_status(:success)
    end
    it "タイトルの表示が正しい" do
      assert_select "title", title
    end
  end

  describe "GET #home" do
    before { get root_path }
    let(:page_title) { "" }
    it_behaves_like "レスポンス、タイトル確認"
  end

  describe "GET #help" do
    before { get help_path }
    let(:page_title) { "Help | " }
    it_behaves_like "レスポンス、タイトル確認"
  end

  describe "GET #about" do
    before { get about_path }
    let(:page_title) { "About | " }
    it_behaves_like "レスポンス、タイトル確認"
  end

  describe "GET #contact" do
    before { get contact_path }
    let(:page_title) { "Contact | " }
    it_behaves_like "レスポンス、タイトル確認"
  end

  describe "GET #contact" do
    before { get contact_path }
    let(:page_title) { "Contact | " }
    it_behaves_like "レスポンス、タイトル確認"
  end
end
