class ConcertsController < ApplicationController

  def show
    @concert = Concert.find(params[:id])
    @venue = Venue.find(@concert.venue_id)
    @concert_songs = @concert.concert_songs.sort_by(&:order)
    puts "\n\n\nSORTED?"
    p @concert_songs
    puts "AFTER\n\n\n"
  end

end
