require 'spec_helper'

describe SessionsController do

  describe "#create" do

    before(:each) do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      get :create, provider: 'facebook'
    end

    it "should be valid" do
      expect(response).to be_success
    end

    it "should set user_id in the session" do
      expect(session[:user_id]).to be_true
    end
  end
end
