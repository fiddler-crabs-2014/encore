class ConcertsController < ApplicationController

  def show
    @concert = Concert.find(params[:id])
    @venue = Venue.find(@concert.venue_id)
    @concert_songs = @concert.concert_songs.sort_by(&:order)
    @concert_songs
  end

end
