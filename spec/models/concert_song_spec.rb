require 'spec_helper'

describe ConcertSong do

  describe "associations" do
    it { should belong_to(:concert) }
    it { should belong_to(:song) }
  end

  it "has a valid factory" do
    FactoryGirl.build(:concert_song).should be_valid
  end

  it "is invalid without a concert_id" do
    FactoryGirl.build(:concert_song, concert_id: nil).should_not be_valid
  end

  it "is invalid without a song_id" do
    FactoryGirl.build(:concert_song, song_id: nil).should_not be_valid
  end
end
