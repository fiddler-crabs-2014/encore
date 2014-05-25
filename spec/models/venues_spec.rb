require 'spec_helper'

describe Venue do

  it "has a valid factory" do
    FactoryGirl.create(:venue).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:venue, name: nil).should_not be_valid
  end

  it "is invalid without a city" do
    FactoryGirl.build(:venue, name: nil).should_not be_valid
  end

  it "is invalid without a state" do
    FactoryGirl.build(:venue, name: nil).should_not be_valid
  end

end
