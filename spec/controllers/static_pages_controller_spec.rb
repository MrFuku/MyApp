require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  let(:title) { "#{page_title}Ruby on Rails Tutorial Sample App" }

  shared_examples "レスポンス、タイトル確認" do
    it "レスポンスが正常である" do
      expect(response).to have_http_status(:success)
    end
    it "タイトルの表示が正しい" do
      assert_select "title", title
    end
  end

  describe "GET #home" do
    before { get :home }
    let(:page_title) { "" }
    it_behaves_like "レスポンス、タイトル確認"
  end

  describe "GET #help" do
    before { get :help }
    let(:page_title) { "Help | " }
    it_behaves_like "レスポンス、タイトル確認"
  end

  describe "GET #about" do
    before { get :about }
    let(:page_title) { "About | " }
    it_behaves_like "レスポンス、タイトル確認"
  end
end
