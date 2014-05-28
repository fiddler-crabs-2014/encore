class ConcertSongsController < ApplicationController
  def create
    @concert = Concert.find(params[:concert_id])
    @venue = @concert.venue
    @concert_songs = @concert.concert_songs.sort_by(&:order)
    @song_names = @concert_songs.map { |c_s| c_s.song.title }
    identifier = params[:video_link][/(?<=v=).*/]
    artist = @concert.artists.find_by(name: params[:artist_name])
    song = artist.songs.find_by(title: params[:song_name])
    concert_song = @concert.concert_songs.find_by(song_id: song.id)
    video = Video.find_or_initialize_by(identifier: identifier, concert_song_id: concert_song.id)
    if video.save
      redirect_to :back
    else
      flash[:warning] = "Unsuccessful submission. Please try again."
      render "concerts/show"
    end
  end
end
