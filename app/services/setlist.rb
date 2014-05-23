class Setlist

  def self.search(band_name, mbid)
    # setlists = []

    p band_name

    band = band_name
    setlists = JSON.parse(Net::HTTP.get_response(URI.parse("http://api.setlist.fm/rest/0.1/artist/#{mbid}/setlists.json")).body)
    # total_pages = pages / 20
    # (1..total_pages).each do |x|
    #   setlists << JSON.parse(Net::HTTP.get_response(URI.parse("http://api.setlist.fm/rest/0.1/artist/#{mbid}/setlists.json?p=#{x}")).body)
    # end
    # date = setlists["setlists"]["setlist"][0]["@eventDate"]
    # tour = setlists["setlists"]["setlist"][0]["@tour"]
    # venue = setlists["setlists"]["setlist"][0]["venue"]["@name"]
    # location = setlists["setlists"]["setlist"][0]["venue"]["city"]["@state"]

    # songs = setlists["setlists"]["setlist"][0]["sets"]["set"]["song"].map do |song|
    #   song["@name"]
    # end

    concerts = []
    setlists["setlists"]["setlist"].each { |concert| concerts << "#{Date.parse(concert["@eventDate"]).strftime('%B %e %Y')}, #{concert["@tour"]}, #{concert["venue"]["@name"]}, #{concert["venue"]["city"]["@name"]}, #{concert["venue"]["city"]["@state"]}" }

    return band, concerts
  end

end
