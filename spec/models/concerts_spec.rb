require 'spec_helper'

describe Concert do

  describe "associations" do
    it { should belong_to(:venue) }
    it { should have_many(:concert_artists) }
    it { should have_many(:artists).through(:concert_artists) }
    it { should have_many(:concert_songs) }
    it { should have_many(:songs).through(:concert_songs) }
    it { should have_many(:attended_concerts) }
    it { should have_many(:users).through(:attended_concerts) }
  end

  it "has a valid factory" do
    FactoryGirl.create(:concert).should be_valid
  end

  it "is invalid without a date" do
    FactoryGirl.build(:concert, date: nil).should_not be_valid
  end

  it "accepts a date as a date" do
    FactoryGirl.build(:concert, date: Date.new(2014, 5, 24)).should be_valid
  end

  # it "does not accept a string as a date" do
  #   FactoryGirl.build(:concert, date: "January 25 2014").should_not be_valid
  # end

  it "has a concert ID" do
    FactoryGirl.build(:venue, name: nil).should_not be_valid
  end

end
