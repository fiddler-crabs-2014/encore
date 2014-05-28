require 'spec_helper'

describe User do

  it { should validate_presence_of(:email) }

  describe "associations" do
    it { should have_many(:attended_concerts) }
    it { should have_many(:concerts).through(:attended_concerts) }
  end

  it "allows user to follow another user" do
    u1 = User.create(provider: "a", uid: "b", name: "test_name", oauth_token: "c", oauth_expires_at: "1999-9-9", email: "q@gmail.com")
    u2 = User.create(provider: "a", uid: "b", name: "test_name", oauth_token: "c", oauth_expires_at: "1999-9-9", email: "qq@gmail.com")
    expect { u1.follow!(u2) }.to change { Relationship.count }.by(1)
  end

  it "allows user to unfollow another user" do
    u1 = User.create(provider: "a", uid: "b", name: "test_name", oauth_token: "c", oauth_expires_at: "1999-9-9", email: "q@gmail.com")
    u2 = User.create(provider: "a", uid: "b", name: "test_name", oauth_token: "c", oauth_expires_at: "1999-9-9", email: "qq@gmail.com")
    u1.follow!(u2)
    expect { u1.unfollow!(u2) }.to change { Relationship.count }.by(-1)
  end

  it "returns an array of people followed by the user" do
    u1 = User.create(provider: "a", uid: "b", name: "test_name", oauth_token: "c", oauth_expires_at: "1999-9-9", email: "q@gmail.com")
    u2 = User.create(provider: "a", uid: "b", name: "test_name", oauth_token: "c", oauth_expires_at: "1999-9-9", email: "qq@gmail.com")
    u1.follow!(u2)
    u1.following?(u1.id).length.should eq(1)
  end

  it "returns an array of people following the user" do
    u1 = User.create(provider: "a", uid: "b", name: "test_name", oauth_token: "c", oauth_expires_at: "1999-9-9", email: "q@gmail.com")
    u2 = User.create(provider: "a", uid: "b", name: "test_name", oauth_token: "c", oauth_expires_at: "1999-9-9", email: "qq@gmail.com")
    u2.follow!(u1)
    u1.followers(u1.id).length.should eq(1)
  end

end
