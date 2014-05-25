class SongsController < ApplicationController
  def create
    @artist = Artist.find(params[:artist_id])
    @concert = Concert.find(params[:concert_id])
    @song = @artist.songs.create(title: params[:song])
    @concert.concert_songs.create(song_id: @song.id, video_identifier: params[:song_id])
    render text: "Song added!"
  end
end
