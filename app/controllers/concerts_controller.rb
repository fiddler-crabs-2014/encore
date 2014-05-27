class ConcertsController < ApplicationController

  def show
    @concert = Concert.find(params[:id])
    @venue = Venue.find(@concert.venue_id)
    @concert_photo = @concert.concert_photos.new
    @concert_songs = @concert.concert_songs.sort_by(&:order)
  end

end
