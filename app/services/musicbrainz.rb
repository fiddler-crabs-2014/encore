class Musicbrainz

  def self.search(artist)
    mb_results = MusicBrainz::Artist.search(artist)
    mbid = mb_results[0][:mbid]

    return mbid
  end

end

