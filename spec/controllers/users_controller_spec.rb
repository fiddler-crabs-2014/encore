require 'spec_helper'

describe UsersController do
  let!(:u1) { FactoryGirl.create(:user) }
  let!(:u2) { FactoryGirl.create(:user) }
  let!(:c1) { FactoryGirl.create(:concert) }
  let!(:c2) { FactoryGirl.create(:concert) }
  before { u1.concerts << c1 }
  before { u1.concerts << c2 }

  describe "GET #index" do
    it "assigns all users to @users" do
      controller.stub(current_user: u1)
      get :index
      assigns(:users).length.should eq(2)
    end
  end

  describe "GET #show" do
    before { controller.stub(current_user: u2)}
    it "assigns user to @user" do
      get :show, id: u1.id
      assigns(:user).id.should eq(u1.id)
    end

    it "assigns user's attended concerts to @concerts" do
      get :show, id: u1.id
      assigns(:concerts)[0].id.should eq(c1.id)
      assigns(:concerts)[1].id.should eq(c2.id)
    end
  end
end
