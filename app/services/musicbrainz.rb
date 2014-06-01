require 'net/http'
class Musicbrainz

  def self.search(artist)
    mb_results = MusicBrainz::Artist.search(artist)
    if mb_results.empty?
      return false
    # In rare cases, MusicBrainz returns arrays containing multiple artists
    # This conditional assumes only one of the artists will return results
    # from setlist.fm. Definitely not foolproof - need a better solution
    elsif mb_results.length > 1
      mb_results.each do |mb_result|
        mbid = mb_result[:mbid]
        result = Net::HTTP.get_response(URI.parse(
                  "http://api.setlist.fm/rest/0.1/artist/#{mbid}/setlists.json")
                ).body
        return mbid unless result == "not found\n"
      end
    else
      return mb_results[0][:mbid]
    end
    return nil
  end

end

