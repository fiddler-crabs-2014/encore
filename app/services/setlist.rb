require 'net/http'
class Setlist

  def self.search(band_name, mbid)
    band = band_name
    setlists = JSON.parse(Net::HTTP.get_response(URI.parse("http://api.setlist.fm/rest/0.1/artist/#{mbid}/setlists.json")).body)
    # total_pages = pages / 20
    # (1..total_pages).each do |x|
    #   setlists << JSON.parse(Net::HTTP.get_response(URI.parse("http://api.setlist.fm/rest/0.1/artist/#{mbid}/setlists.json?p=#{x}")).body)
    # end
    set_songs = []
    setlists["setlists"]["setlist"].each do |set|
      if set["sets"].empty?
        set_songs << [nil]
      elsif set["sets"]["set"].is_a? Array
        set_songs << Array.new(
          set["sets"]["set"].map do |set|
            if set["song"].is_a? Array
              set["song"].map do |song|
                song["@name"]
              end
            elsif set["song"].is_a? Hash
              set["song"]["@name"]
            end
          end
        )
      elsif set["sets"]["set"]["song"].is_a? Hash
        set_songs << set["song"]["@name"]
      else
        set_songs << set["sets"]["set"]["song"].map { |song| song["@name"] }
      end
    end

    concerts = []
    setlists["setlists"]["setlist"].each { |concert| concerts << ["#{Date.parse(concert["@eventDate"]).strftime('%B %e %Y')}, #{concert["@tour"]}, #{concert["venue"]["@name"]}, #{concert["venue"]["city"]["@name"]}, #{concert["venue"]["city"]["@state"]}"] }

    concerts_with_sets = concerts.zip(set_songs)

    return band, concerts_with_sets
  end

end
