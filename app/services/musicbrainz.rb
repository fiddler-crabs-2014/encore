class Musicbrainz

  def self.search(artist)
    mb_results = MusicBrainz::Artist.search(artist)
    if mb_results.empty?
      return false
    else
      return mb_results[0][:mbid]
    end
  end

end

