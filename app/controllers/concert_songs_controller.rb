class ConcertSongsController < ApplicationController
  def create
    identifier = params[:video_link][/(?<=v=).*/]
    artist = Artist.find_by(name: params[:artist_name])
    song = Song.find_by(title: params[:song_name], artist_id: artist.id )
    concert = Concert.find(params[:concert_id])
    concert_song = ConcertSong.find_by(concert_id: concert.id, song_id: song.id)
    Video.find_or_create_by(identifier: identifier, concert_song_id: concert_song.id)
    redirect_to :back
  end
end
