class SongsController < ApplicationController
  def create
    p artist = Artist.find(params[:artist_id])
    p concert = Concert.find(params[:concert_id])
    p song = Song.find_by(title: params[:song], artist_id: artist.id)
    p concert_song = concert.concert_songs.find_by(song_id: song.id)
    p add_video(params[:song_id], concert_song)
    render text: "Song added!"
  end

  private
  def add_video(identifier, concert_song)
    video = Video.find_or_initialize_by(identifier: identifier)
    video.concert_song_id = concert_song.id
    video.save!
  end
end
