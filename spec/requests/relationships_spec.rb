require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "Post #create" do
    context "未ログイン時" do
      it "ログイン画面にリダイレクトすること" do
        expect {
          post relationships_path
        }.to change(Relationship, :count).by(0)
        assert_redirected_to login_path
      end
    end
  end

  describe "Delete #destroy" do
    context "未ログイン時" do
      it "ログイン画面にリダイレクトすること" do
        expect {
          delete relationship_path(id: 1)
        }.to change(Relationship, :count).by(0)
        assert_redirected_to login_path
      end
    end
  end
end
