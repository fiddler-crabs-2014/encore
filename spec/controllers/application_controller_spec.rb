require 'spec_helper'

describe ApplicationController do

  describe "user controller methods" do

    let(:user) { create(:user) }

    describe "#current_user" do
      before { controller.stub(current_user: user) }

      it "returns an @current_user object when user signed in" do
        controller.current_user.should eq user
      end

    end

    describe "#signed_in?" do
      it "returns true if user signed in" do
        controller.stub(current_user: user)
        controller.signed_in?.should be_true
      end

      it "returns false if user not signed in" do
        controller.signed_in?.should be_false
      end
    end

  end
end
