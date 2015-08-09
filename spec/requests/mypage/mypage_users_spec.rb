require 'rails_helper'

RSpec.describe "Mypage::Users", type: :request do
  describe "GET /mypage_users" do
    it "works! (now write some real specs)" do
      get mypage_users_path
      expect(response).to have_http_status(200)
    end
  end
end
