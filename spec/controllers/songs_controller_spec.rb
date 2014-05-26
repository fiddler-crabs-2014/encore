require 'spec_helper'

describe SongsController do
  let(:artist) { Artist.create(name: "Muse") }
  let(:venue) { Venue.create(name: "Empire Polo Club", city: "Indio", state: "California") }
  let(:concert) { Concert.create(date: "April 19 2014", venue_id: venue.id) }

  describe "GET #create" do

    context "with valid params" do
      it "returns http success" do
        params = {"song"=>"Knights of Cydonia", "song_id"=>"zP9_5JYcnno", "concert_id"=> concert.id, "artist_id"=> artist.id, "authenticity_token"=>"HYcpdb6UOp26xvk4pBAKFRqYMxVSkuK4aK7fsoVdKW4=", "action"=>"create", "controller"=>"songs"}
        get :create, params
        response.should be_success
      end
    end
  end
end
