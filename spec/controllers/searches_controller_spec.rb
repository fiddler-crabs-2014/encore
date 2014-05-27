require 'spec_helper'

describe SearchesController do
  let(:artist) { create(:artist, name: "Killswitch Engage") }

  describe "GET #search" do
    context "with valid search input" do
      it "assigns the search input to @band" do
        get :search, band: artist.name
        assigns(:band).should eq(artist)
      end

      it "assigns search results to @results" do
        get :search, band: artist.name
        assigns(:results).should_not eq(nil)
      end

      it "creates a new artist " do
        expect {
          get :search, band: artist.name
          }.to change { Artist.count }.by(1)
      end

      it "renders the #search view" do
        get :search, band: artist.name
        response.should render_template(:search)
      end
    end

    context "when an artist already exists" do
      before { Artist.create(name: artist.name) }

      it "doesn't create a new artist record" do
        expect {
          get :search, band: artist.name
        }.to_not change{ Artist.count }.by(1)
      end
    end

    context "with invalid search input" do
      it "flashes a warning message" do
        get :search, band: ""
        flash[:warning].should eq("Sorry - we couldn't find an artist with that name.")
      end

      it "re-renders the homepage" do
        get :search, band: ""
        response.should render_template(:index)
      end
    end
  end

  describe "GET #search_youtube" do
    query = { "band"=>"Muse", "concert"=>"April 19 2014, The 2nd Law, Empire Polo Club, Indio, California",
                              "songs"=>"Knights of Cydonia,Interlude,Hysteria,Bliss,Animals,Stockholm Syndrome,
                              The 2nd Law: Unsustainable,Madness,Starlight,Time Is Running Out,The 2nd Law: Isolated System,
                              Uprising,Survival" }
    let!(:artist) { Artist.create(name: "Muse") }

    context "with valid query" do
      it "renders the #search_youtube view" do
        get :search_youtube, query
        response.should render_template(:search_youtube)
      end

      it "assigns requested songs to @songs" do
        get :search_youtube, query
        songs = ["Knights of Cydonia,Interlude,Hysteria,Bliss,Animals,Stockholm Syndrome,\n                              The 2nd Law: Unsustainable,Madness,Starlight,Time Is Running Out,The 2nd Law: Isolated System,\n                              Uprising,Survival"]
        assigns(:songs).should eq(songs)
      end

      it "assigns requested concert to @concert" do
        get :search_youtube, query
        assigns(:concert).date.to_s.should eq("2014-04-19")
      end

      it "assigns requested band to @band" do
        get :search_youtube, query
        assigns(:band).name.should eq("Muse")
      end

      it "assigns requested date to @date" do
        get :search_youtube, query
        assigns(:date).should eq("April 19 2014")
      end

      it "assigns requested tour to @tour" do
        get :search_youtube, query
        assigns(:tour).should eq("The 2nd Law")
      end

      it "assigns requested venue to @venue" do
        get :search_youtube, query
        assigns(:venue).name.should eq("Empire Polo Club")
      end

      it "assigns song titles and associated video_identifiers as @titles_ids" do
        get :search_youtube, query
        assigns(:titles_ids).should_not be_nil
      end

      it "creates a new venue" do
        expect {
          get :search_youtube, query
          }.to change { Venue.count }.by(1)
      end

      it "creates a new concert" do
        expect {
          get :search_youtube, query
          }.to change { Concert.count }.by(1)
      end

      it "creates a new concert_artist" do
        expect {
          get :search_youtube, query
          }.to change { ConcertArtist.count }.by(1)
      end

    end

    context "when a venue already exists" do
      before { Venue.create(name: "Empire Polo Club", city: "Indio", state: "California") }

      it "doesn't create a new venue record" do
        expect {
          get :search_youtube, query
        }.to_not change { Venue.count }.by(1)
      end
    end

    context "when a concert already exists" do
      let(:venue) { Venue.create(name: "Empire Polo Club", city: "Indio", state: "California") }
      let!(:concert) { Concert.create(date: "April 19 2014", venue_id: venue.id) }

      it "doesn't create a new concert record" do
        expect {
          get :search_youtube, query
        }.to_not change { Concert.count }.by(1)
      end
    end

    context "when a concert_artist already exists" do
      let(:venue) { Venue.create(name: "Empire Polo Club", city: "Indio", state: "California") }
      let(:artist) { Artist.create(name: "Muse") }
      let(:concert) { Concert.create(date: "April 19 2014", venue_id: venue.id) }
      let!(:concert_artist) { ConcertArtist.create(concert_id: concert.id, artist_id: artist.id) }
      it "doesn't create a new concert_artist record" do
        expect {
          get :search_youtube, query
        }.to_not change { ConcertArtist.count }.by(1)
      end
    end
  end
end
