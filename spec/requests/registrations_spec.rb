require 'rails_helper'

RSpec.describe "Registrations", type: :request do

  describe "Get #new" do
    it "レスポンスが正常である" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end
