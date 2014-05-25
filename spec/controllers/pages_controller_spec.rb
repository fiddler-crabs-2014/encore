require 'spec_helper'

describe PagesController do
  let(:params) { "Killswitch Engage" }

  describe "GET #search" do
    context "with valid search input" do
      it "assigns the search input to @band" do
        get :search, band: params
        assigns(:band).should eq(params)
      end

      it "assigns search results to @results" do
        get :search, band: params
        assigns(:results).should_not  eq(nil)
      end

      it "creates a new artist " do
        expect {
          get :search, band: params
          }.to change { Artist.count }.by(1)
      end

      it "renders the #search view" do
        get :search, band: params
        response.should render_template(:search)
      end
    end

    context "when an artist already exists" do
      before { Artist.create(name: params) }

      it "doesn't create a new artist record" do
        expect {
          get :search, band: params
        }.to_not change { Artist.count }.by(1)
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
    query = {"band"=>"muse", "concert"=>"April 19 2014, The 2nd Law, Empire Polo Club, Indio, California", "songs"=>["Knights of Cydonia", "Interlude", "Hysteria", "Bliss", "Animals", "Stockholm Syndrome", "The 2nd Law: Unsustainable", "Madness", "Starlight", "Time Is Running Out", "The 2nd Law: Isolated System", "Uprising", "Survival"]}
    context "with valid query" do
      it "renders the #search_youtube view" do
        get :search_youtube, query
        response.should render_template(:search_youtube)
      end

      it "assigns requested songs to @songs" do
        get :search_youtube, query
        songs = ["Knights of Cydonia", "Interlude", "Hysteria", "Bliss", "Animals", "Stockholm Syndrome", "The 2nd Law: Unsustainable", "Madness", "Starlight", "Time Is Running Out", "The 2nd Law: Isolated System", "Uprising", "Survival"]
        assigns(:songs).should eq(songs)
      end

      it "assigns requested band to @band" do
        get :search_youtube, query
        assigns(:band).should eq("muse")
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
        assigns(:venue).should eq("Empire Polo Club")
      end

      it "assigns requested city to @city" do
        get :search_youtube, query
        assigns(:city).should eq("Indio")
      end

      it "assigns requested state to @state" do
        get :search_youtube, query
        assigns(:state).should eq("California")
      end

      it "assigns song titles and associated video_identifiers as @titles_ids" do
        get :search_youtube, query
        youtube_response = {"Muse - Coachella 2014 (Weekend 2)"=>"zP9_5JYcnno", "Calvin Harris - Coachella 2014 (Weekend 2)"=>"QAZzqibvPPU", "Pet Shop Boys [West End Girls] - Coachella 2014 (Weekend 2)"=>"DEqJpZsKPQg", "Skrillex - Coachella 2014 (Weekend 2)"=>"aMl9EthIZJQ", "Pet Shop Boys - Coachella 2014 (Weekend 2)"=>"GseQKBMaqjo", "Nas - Coachella 2014 (Weekend 2)"=>"SXcmuNP5Ays", "Mogwai - Coachella (Weekend 2)"=>"79mBusjbLUA", "Galantis - Coachella 2014 (Weekend 2)"=>"0_cki1tVT1o", "Martin Garrix with Dillon Francis - Coachella 2014 (Weekend 2)"=>"om3qms3VuJY", "AFI - Coachella 2014 (Weekend 2)"=>"km8WX5lSQ1Q", "Ellie Goulding - Coachella 2014 (Weekend 2)"=>"7yhafcdJfuI", "City And Colour - Coachella 2014 (Weekend 2)"=>"BEkjtfu3Psc", "Carnage - Coachella 2014 (Weekend 2)"=>"uR7lXAj48bM", "The Glitch Mob - Coachella 2014 (Weekend 2)"=>"72zL_VhSaTQ", "Jhene Aiko \"Higher\" Live at Coachella 2014 W1 (Ending)"=>"QPqVMhVaYcI", "Coachella Valley Music and Arts Festival 2014"=>"6AbyCyjgk3U", "Dillon Francis LIVE @ Coachella Weekend 1 2014"=>"vS96hI1AV28", "Vampire Weekend (Live) Coachella 2013"=>"fA8AQpH7cq0", "Muse performing \"Starlight\" at Coachella on April 19, 2014"=>"PZtd_ksJdMw", "Muse performing \"Madness\" at Coachella on April 19, 2014 at"=>"N7Q7xMxgt4E", "Muse performing \"Animals\" at Coachella - April 19, 2014 - C"=>"38IdK4UyHCI", "Muse performing \"Knights of Cydonia\" at Coachella on April"=>"XYrkakeSM8s", "Muse performing \"Time Is Running Out\" at Coachella on April"=>"fVZEuivg9oU", "Muse performing \"The 2nd Law: Isolated System\" and \"Uprisin"=>"9WBKm3PP9YQ", "Muse-Time is running out live Coachella 2014"=>"3_82GKVoilo", "S0 News March 6, 2014: MUSE, Solar Eruption Watch"=>"SzbZBW3oRjQ", "Muse At Izod Center 4/19/13 - Entire Show (Improved Audio)"=>"zV8IWd2Xrf8", "Fat Boy Slim performing \"Right Here, Right Now\" at Coachell"=>"opWi05jj_vA", "Jake Bugg - Country Song - live Coachella, April 19, 2013"=>"Cf8UWhFtDRk", "(HD) Muse - Man With A Harmonica + Knights of Cydonia - IZOD Center, April 19, 2013"=>"tDvgW8cEeKs", "Coachella 2014: Muse Tells Us What They Love About Performing Live"=>"9WqpxDvjKAQ", "Muse (Live) - Survival - Oracle Arena - 1/28/13 - Oakland CA"=>"CxxdokwJEu8", "Muse - Uprising Coachella 2014"=>"MQyw_piB9xk", "M.U.S.E. On Location: Universal Studios Hollywood Despicable Me: Minion Mayhem"=>"hZnMgv9ouzc", "Animals (Live) Muse - Oakland,California - Oracle Arena - 2nd Law Tour - 1/28/2013"=>"P_k9gsWuBps"}
        assigns(:titles_ids).should eq(youtube_response)
      end
    end
  end
end
