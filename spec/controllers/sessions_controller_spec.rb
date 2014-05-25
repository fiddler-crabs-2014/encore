require 'spec_helper'

describe SessionsController do
  let(:user) { create(:user) }
  describe "#create" do
    before do
        # Not sure how to get this working in the controller. Always get this error:
        # Failure/Error: get :create, provider: 'facebook'
        #  NoMethodError:
        #    undefined method `slice' for nil:NilClass
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it "logs in with facebook successfully" do
      post :create, provider: 'facebook'
      expect(response).to be_success
    end

    it "sets user_id in the session" do
      post :create, provider: 'facebook'
      expect(session[:user_id]).to be_true
    end
  end

  describe "#destroy" do
    before do
      controller.stub(current_user: create(:user))
    end

    it "clears user_id from the session" do
      get :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
