require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views

  let(:title) { "#{page_title} | Ruby on Rails Tutorial Sample App" }

  shared_examples "レスポンスが正常である" do
    it { expect(response).to have_http_status(:success) }
  end

  shared_examples "タイトルの表示が正しい" do
    it { assert_select "title", title }
  end

  describe "GET #home" do
    before { get :home }
    let(:page_title) { "Home" }
    it_behaves_like "レスポンスが正常である"
    it_behaves_like "タイトルの表示が正しい"
  end

  describe "GET #help" do
    before { get :help }
    let(:page_title) { "Help" }
    it_behaves_like "レスポンスが正常である"
    it_behaves_like "タイトルの表示が正しい"
  end

  describe "GET #about" do
    before { get :about }
    let(:page_title) { "About" }
    it_behaves_like "レスポンスが正常である"
    it_behaves_like "タイトルの表示が正しい"
  end
end
