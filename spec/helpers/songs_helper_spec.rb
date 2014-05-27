require 'spec_helper'

describe SongsHelper do
  let!(:song) { Song.create(title: "test", artist_id: 1) }
  let!(:concert) { Concert.create(date: "1999-9-1", venue_id: 1) }
  let!(:concert_song) { ConcertSong.create(order: 1, concert_id: 1, song_id: 1) }
  let!(:video) { Video.create(identifier: "test", concert_song_id: 1) }
  describe "#song_title" do
    it "displays song title" do
      helper.song_title(song.id).should eq("test")
    end
  end

  describe "#song_title" do
    it "returns an array of associated videos" do
      helper.song_videos(song.id).length.should eq(1)
    end
  end
end
