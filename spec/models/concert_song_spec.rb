require 'spec_helper'

describe ConcertSong do

  it { should validate_presence_of(:video_identifier) }

  describe "associations" do
    it { should belong_to(:concert) }
    it { should belong_to(:song) }
    it { should validate_uniqueness_of(:video_identifier).scoped_to(:concert_id) }
  end

end
