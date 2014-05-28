require 'spec_helper'

describe SongsController do

  describe "GET #create" do
    let!(:artist) { Artist.create(name: "Muse") }
    let!(:venue) { Venue.create(name: "Empire Polo Club", city: "Indio", state: "California") }
    let!(:concert) { Concert.create(date: "April 19 2014", venue_id: venue.id) }
    let!(:song) { Song.create(title: "Knights of Cydonia", artist_id: artist.id) }
    # let!(:song2) { Song.create(title: "Knights of Cydonia", artist_id: 2) }
    let!(:concert_song) { ConcertSong.create(concert_id: concert.id, song_id: song.id, order: 0) }
    # let!(:concert_song2) { ConcertSong.create(concert_id: concert.id, song_id: song2.id, order: 1) }

    context "with valid params" do
      it "returns http success" do
        params = {"song"=>"Knights of Cydonia", "song_id"=>"zP9_5JYcnno", "concert_id"=> concert.id, "artist_id"=> artist.id, "authenticity_token"=>"HYcpdb6UOp26xvk4pBAKFRqYMxVSkuK4aK7fsoVdKW4=", "action"=>"create", "controller"=>"songs"}
        get :create, params
        response.should be_success
      end

      it "renders text" do
        params = {"song"=>"Knights of Cydonia", "song_id"=>"zP9_5JYcnno", "concert_id"=> concert.id, "artist_id"=> artist.id, "authenticity_token"=>"HYcpdb6UOp26xvk4pBAKFRqYMxVSkuK4aK7fsoVdKW4=", "action"=>"create", "controller"=>"songs"}
        get :create, params
        response.body.should eq("Song added!")
      end
    end
  end
end
