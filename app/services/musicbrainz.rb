class Musicbrainz

  def self.search(artist)
    mb_results = MusicBrainz::Artist.search(artist)
    mbid = mb_results[0][:mbid]
    binding.pry
    return mbid
  end

end

