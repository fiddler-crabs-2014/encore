module SongsHelper

  def song_title(song_id)
    Song.find(song_id).title
  end

  def song_videos(song_id)
    Video.where(concert_song_id: song_id)
  end
end
