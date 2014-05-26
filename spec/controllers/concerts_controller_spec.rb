require 'spec_helper'

describe ConcertsController do
  let(:artist) { create :artist }
  let(:concert) { create :concert }
  let(:venue) { create :venue }

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
end








