class ConcertsController < ApplicationController

  def show
    @concert = Concert.find(params[:id])
    @venue = Venue.find(@concert.venue_id)
    @concert_photo = @concert.concert_photos.new
    @concert_songs = @concert.concert_songs.sort_by(&:order)
    @song_names = @concert_songs.map { |c_s| c_s.song.title }
    # @concert_song = ConcertSong.new
  end
end
