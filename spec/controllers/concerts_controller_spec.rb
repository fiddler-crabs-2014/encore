require 'spec_helper'

describe ConcertsController do
  let(:artist) { create :artist }
  let(:concert) { create :concert }
  let(:venue) { create :venue }
  let!(:song) { Song.create(title: "test_song", artist_id: artist.id) }
  let!(:concert_song) { ConcertSong.create(order: 0, concert_id: concert.id, song_id: song.id) }
  let!(:video) { Video.create(identifier: "test", concert_song_id: concert_song.id) }
  before do
    concert.update(venue: venue)
    concert.save!
  end

  describe "GET #show" do

    it "is successful" do
      get :show, id: concert.id
      expect(response).to be_success
    end

    it "assigns @concert to concert" do
      get :show, id: concert.id
      expect(assigns(:concert)).to eq concert
    end

    it "assigns @venue to venue" do
      get :show, id: concert.id
      expect(assigns(:venue)).to eq venue
    end
  end

  describe "POST #flag_video" do
    it "assigns targeted video as @video" do
      post :flag_video, video_id: video.id
      expect(assigns(:video).identifier).to eq("test")
    end
  end

  describe "POST #unflag_video" do
    it "assigns targeted video as @video" do
      post :unflag_video, video_id: video.id
      expect(assigns(:video).identifier).to eq("test")
    end
  end
end








