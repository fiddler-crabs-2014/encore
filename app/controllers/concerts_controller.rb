<<<<<<< HEAD
class ConcertsController < ApplicationController

  def new
  end

  def create
  end

=======
class ConcertsController < ActionController::Base
  def create
    p "GOT YOU"
    p params
    # Suggest using first_or_create
    artist = Artist.where(name: params[:band]).first_or_create
    venue = Venue.where(name: params[:venue], city: params[:city], state: params[:state]).first_or_create
    concert = Concert.where(date: params[:date], venue_id: venue.id).first_or_create
    artist.concert_artists.create(concert_id: concert.id, artist_id: artist.id ,concert_position: "test")
    artist.concerts
    if venue.save
      p "VENUE SAVED"
      p "VENUE ID is: #{venue.id}"
    else
      "ERROROROROROROROROROR"
    end

  end
>>>>>>> a61013c0bab0fde01dc3dd8dc73d2eda31a78674
end
